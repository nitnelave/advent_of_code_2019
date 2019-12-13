# Day 13 -- C

Yet another Intcode day... This one is in C. I'll probably stick to the family
of C-like languages to keep copy-pasting my implementation. There's a display
of the screen if you're interested, you just have to uncomment the
`//print_game(c);` line.

This is C, so you'll have to compile the code:

```
gcc solution.c
```

Then run it:
```
./a.out
```

The solution runs absurdly fast, around ~60 ms _in debug mode_, and faster than
I could (easily) measure in release mode.

Problem: [Care Package](https://adventofcode.com/2019/day/13)
