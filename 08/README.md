# Day 08 -- Brainfuck

Today, as the problems get harder, we'll move on to a simpler language...
literally. One of the simplest languages ever invented, Brainfuck has 8
instructions, that come in pairs.

You are manipulating an infinite tape of memory, initialized at 0. You have a
cursor that indicates a cell, and that's pretty much it. The instructions
are:

 - `+`, `-`: Increment or decrement the value under the cursor.
 - `>`, `<`: Move the cursor to the right/left by one.
 - `[`: Jump to the matching `]` if the value under the cursor is 0.
 - `]`: Jump to the matching `[` if the value under the cursor is not 0.
 - `,`, `.`: Read/write one byte.

Strictly speaking, each cell should be limited to a byte. However, since we are
manipulating numbers that are bigger than 255, the interpreter that is needed
here will have at least 2 bytes per cell. Moreover, `,` should return `-1` when
we reach the end of the file, like it does in C.

To get the answer to the first part, execute `solution.bf` with your input.

To get the answer to the second part, save your input to `input.txt` and run
`python3 solution.py`. No, I did not implement the second part in Brainfuck,
what did you expect? It's all written by hand, and I only have a day!

Problem: [Space Image Format](https://adventofcode.com/2019/day/8)
