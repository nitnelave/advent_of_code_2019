int at(array(int) data, int index) {
  return data[index];
}

int set(array(int) data, int index, int value) {
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


int get_index(int op, array(int) data, int pc, int rel_base, int arg_num) {
  int mod = get_modifier(op, arg_num);
  int arg_index = pc + arg_num;
  switch (mod) {
    case 0:
      return at(data, arg_index);
    case 1:
      return arg_index;
    case 2:
      // Cast to int in case it's a bignum (i.e. a string).
      return (int)rel_base + (int)at(data, arg_index);
    default:
      write("Unknown mod\n");
      exit(1);
  }
}

int get_val(int op, array(int) data, int pc, int rel_base, int arg_num) {
  int index = get_index(op, data, pc, rel_base, arg_num);
  return at(data, index);
}

void bin_op(int op, array(int) data, int pc, int rel_base) {
  int arg1 = get_val(op, data, pc, rel_base, 1);
  int arg2 = get_val(op, data, pc, rel_base, 2);
  int dest_index = get_index(op, data, pc, rel_base, 3);
  int res;
  // Cast to int for all numerical operations.
  switch ((int)(op % 100)) {
    case 1:
      res = (int)arg1 + (int)arg2;
      break;
    case 2:
      res = (int)arg1 * (int)arg2;
      break;
    case 7:
      res = (int)arg1 < (int)arg2 ? 1 : 0;
      break;
    case 8:
      res = arg1 == arg2 ? 1 : 0;
      break;
    default:
      write("Unknown bin_op\n");
      exit(1);
  }
  set(data, dest_index, res);
}

int jump(int op, array(int) data, int pc, int rel_base) {
  int arg1 = get_val(op, data, pc, rel_base, 1);
  int arg2 = get_val(op, data, pc, rel_base, 2);
  switch ((int)(op % 100)) {
    case 5:
      if (arg1 != 0) return arg2;
      break;
    case 6:
      if (arg1 == 0) return arg2;
      break;
    default:
      write("Unknown jump\n");
      exit(1);
  }
  return pc + 3;
}

class Writer {
  void write_val(int val) {
    write((string)val + "\n");
  }
}

class Reader {
  int read() {
    return (int)Stdio.stdin.getchar() - '0';
  }
}

void write_at(Writer w, int op, array(int) data, int pc, int rel_base) {
  int arg1 = get_val(op, data, pc, rel_base, 1);
  w->write_val(arg1);
}

void read_at(Reader r, int op, array(int) data, int pc, int rel_base) {
  int index = get_index(op, data, pc, rel_base, 1);
  set(data, index, r->read());
}

void run(array(int) data, Reader r, Writer w) {
  int pc = 0;
  int rel_base = 0;
  while(true) {
    int op = at(data, pc);
    // Cast to int in case it's a bignum (i.e. a string).
    int shortop = (int)(op % 100);
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
        read_at(r, op, data, pc, rel_base);
        pc += 2;
        break;
      case 4:
        write_at(w, op, data, pc, rel_base);
        pc += 2;
        break;
      case 9:
        rel_base += get_val(op, data, pc, rel_base, 1);
        pc += 2;
        break;
      case 99:
        return;
      default:
        write("Unknown op: " + op + "\n");
        return;
    }
  }
}

array(int) read_program(string filename) {
  // Allocate a biiiiig array.
  array(int) data = allocate(100000000, 0);
  string contents;
  // Read the file.
  {
    Stdio.File f = Stdio.File();
    f->open(filename, "r");
    contents = f->read();
    f->close();
  }

  // Split at ','
  int index;
  int start;
  for (int stop = 0; stop < sizeof(contents); stop++) {
    if (contents[stop] == ',') {
      // Conversion to int.
      data[index] = (int)contents[start..stop - 1];
      start = stop + 1;
      index++;
    }
  }
  int last = sizeof(contents) - 1;
  // Skip the last '\n'
  if (contents[last] == '\n') last -=1;
  data[index] = contents[start..last];
  return data;
}


int main() {
  array(int) data = read_program("input.txt");
  Writer w = Writer();
  Reader r = Reader();
  run(data, r, w);
  return 0;
}
