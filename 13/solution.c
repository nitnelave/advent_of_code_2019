#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int at(int* data, int index) {
  return data[index];
}

int set(int* data, int index, int value) {
  return data[index] = value;
}

int ipow(int a, int b) {
  int res = 1;
  for (int i = 0; i < b; ++i) {
    res *= a;
  }
  return res;
}

int get_modifier(int op, int arg_num) {
  int base = ipow(10, arg_num + 1);
  return (op / base) % 10;
}


int get_index(int op, int* data, int pc, int rel_base, int arg_num) {
  int mod = get_modifier(op, arg_num);
  int arg_index = pc + arg_num;
  switch (mod) {
    case 0:
      return at(data, arg_index);
    case 1:
      return arg_index;
    case 2:
      return rel_base + at(data, arg_index);
    default:
      printf("Unknown mod\n");
      exit(1);
  }
}

int get_val(int op, int* data, int pc, int rel_base, int arg_num) {
  int index = get_index(op, data, pc, rel_base, arg_num);
  return at(data, index);
}

void bin_op(int op, int* data, int pc, int rel_base) {
  int arg1 = get_val(op, data, pc, rel_base, 1);
  int arg2 = get_val(op, data, pc, rel_base, 2);
  int dest_index = get_index(op, data, pc, rel_base, 3);
  int res;
  // Cast to int for all numerical operations.
  switch ((op % 100)) {
    case 1:
      res = arg1 + arg2;
      break;
    case 2:
      res = arg1 * arg2;
      break;
    case 7:
      res = arg1 < arg2 ? 1 : 0;
      break;
    case 8:
      res = arg1 == arg2 ? 1 : 0;
      break;
    default:
      printf("Unknown bin_op\n");
      exit(1);
  }
  set(data, dest_index, res);
}

int jump(int op, int* data, int pc, int rel_base) {
  int arg1 = get_val(op, data, pc, rel_base, 1);
  int arg2 = get_val(op, data, pc, rel_base, 2);
  switch ((op % 100)) {
    case 5:
      if (arg1 != 0) return arg2;
      break;
    case 6:
      if (arg1 == 0) return arg2;
      break;
    default:
      printf("Unknown jump\n");
      exit(1);
  }
  return pc + 3;
}

#define ROWS 23
#define COLS 44

typedef enum {
  EMPTY = 0,
  WALL = 1,
  BLOCK = 2,
  PADDLE = 3,
  BALL = 4,
} tile;

typedef enum {
  READ_X = 0,
  READ_Y = 1,
  WRITE_VAL = 2,
} phase_enum;

typedef enum {
  LEFT = -1,
  STAY = 0,
  RIGHT = 1,
} direction;

typedef struct {
  tile* board;
  size_t score;
  int x;
  int y;
  int paddle_pos;
  // 0 => get x,
  // 1 => get y,
  // 2 => write value.
  phase_enum phase;
  direction next_input;
} controller;

void init_controller(controller* c) {
  c->board = (tile*)calloc(ROWS * COLS, sizeof(tile));
  c->x = 0;
  c->y = 0;
  c->paddle_pos = 0;
  c->phase = READ_X;
  c->score = 0;
  c->next_input = STAY;
}

tile* get_tile(controller* c, int x, int y) {
  assert(x >= 0 && "Negative x");
  assert(y >= 0 && "Negative y");
  return c->board + x + COLS * y;
}

char get_tile_char(tile t) {
  switch (t) {
    case EMPTY:
      return ' ';
    case WALL:
      return 'X';
    case BLOCK:
      return 'O';
    case PADDLE:
      return '-';
    case BALL:
      return '.';
    default:
      return '#';
  }
}

void print_game(controller* c) {
  for (int y = 0; y < ROWS; ++y) {
    for (int x = 0; x < COLS; ++x) {
      printf("%c", get_tile_char(*get_tile(c, x, y)));
    }
    printf("\n");
  }
  for (int x = 0; x < COLS; ++x) {
    printf("X");
  }
  printf("\n\n");
}

void write_val(controller* c, int val){
  switch (c->phase) {
    case 0:
      c->x = val;
      c->phase = READ_Y;
      break;
    case 1:
      c->y = val;
      c->phase = WRITE_VAL;
      break;
    case 2:
      if (c->x == -1 && c->y == 0) {
        c->score = val;
      } else {
        *get_tile(c, c->x, c->y) = (tile)val;
        if (val == PADDLE) {
          c->paddle_pos = c->x;
        } else if (val == BALL) {
          c->next_input = (direction)(c->x - c->paddle_pos);
          //print_game(c);
        }
      }
      c->phase = READ_X;
      break;
  }
}

int read(controller* c) {
  return c->next_input;
}

void write_at(controller* c, int op, int* data, int pc, int rel_base) {
  int arg1 = get_val(op, data, pc, rel_base, 1);
  write_val(c, arg1);
}

void read_at(controller* c, int op, int* data, int pc, int rel_base) {
  int index = get_index(op, data, pc, rel_base, 1);
  set(data, index, read(c));
}

void run(int* data, controller* c) {
  int pc = 0;
  int rel_base = 0;
  while(1) {
    int op = at(data, pc);
    // Cast to int in case it's a bignum (i.e. a string).
    int shortop = (op % 100);
    switch (shortop) {
      case 1:
      case 2:
      case 7:
      case 8:
        bin_op(op, data, pc, rel_base);
        pc += 4;
        break;
      case 5:
      case 6:
        pc = jump(op, data, pc, rel_base);
        break;
      case 3:
        read_at(c, op, data, pc, rel_base);
        pc += 2;
        break;
      case 4:
        write_at(c, op, data, pc, rel_base);
        pc += 2;
        break;
      case 9:
        rel_base += get_val(op, data, pc, rel_base, 1);
        pc += 2;
        break;
      case 99:
        return;
      default:
        printf("Unknown op: %d\n", op);
        return;
    }
  }
}

int* read_program(const char* filename) {
  // Allocate a biiiiig array.
  int* data = (int*)malloc(10000000);
  char contents[10000];
  size_t num_char = 0;
  // Read the file.
  {
    FILE* f = fopen(filename, "r");
    num_char = fread(contents, sizeof(contents[0]), sizeof(contents), f);
    assert(num_char < sizeof(contents) && "Not everything was read");
    assert(fclose(f) == 0 && "Close failed");
  }

  // Split at ','
  int index = 0;
  int start = 0;
  int stop = 0;
  for (; stop < num_char; stop++) {
    if (contents[stop] == ',') {
      contents[stop] = '\0';
      // Conversion to int.
      data[index] = atoi(&contents[start]);
      start = stop + 1;
      index++;
    }
  }
  if (contents[stop - 1] == '\n') --stop;
  contents[stop] = '\0';
  data[index] = atoi(&contents[start]);
  return data;
}

int count_block_tiles(controller* c) {
  int count = 0;
  for (int i = 0; i < ROWS * COLS; ++i) {
    if (c->board[i] == BLOCK) ++count;
  }
  return count;
}

void run_game(int second_part) {
  int* data = read_program("input.txt");
  if (second_part) {
    data[0] = 2;
  }
  controller c;
  init_controller(&c);
  run(data, &c);
  if (second_part) {
    printf("Score: %zu\n", c.score);
  } else {
    printf("Number of blocks: %d\n", count_block_tiles(&c));
  }
  free(data);
}

int main() {
  run_game(0);
  run_game(1);
  return 0;
}
