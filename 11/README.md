# Day 11 -- VimScript

Today I'll be writing code in my favorite editor *for* my favorite editor.
VimScript is a language in the C family in terms of syntax, but closer to
python in terms of semantics. There's not that much that is interesting about
it, apart from the different scope of variables (local, script, global, buffer,
argument) and the fact that you can weave "regular" text editing operations in
the middle of code, in the Vim language (not VimScript, just regular Vim like
"dd" to delete a line).

To run it, open Vim, run `:source solution.vim`, then `:call
Advent_of_code("input.txt")` (with the name of your input file of course).

Problem: [Space Police](https://adventofcode.com/2019/day/11)
