# Day 09 -- Pike

This language was not initially on my list, but I found it on Wikipedia in the
list of languages with built-in support for bignums (I would come to regret
that). It is (somewhat) statically typed, with dynamic typing supported. Other
than that, it looks like C with classes (so, C++ :) ).

The way bignum works in Pike is that when the numbers get too big to store in
an int, they get implicitly, silently converted to the bignum format... a
string. That works wonders with the silent conversion from int to string that
you get when you do string + int. And when converting a number to bigint, if
it's in an array, AFAIU the whole array gets converted to bigint. This leads to
comical situations like: `2715 + 0 = 27150`. Such laughter! The crowd roars!
Endless comedic value.

To run it, save your input in `input.txt` and give the program input on stdin:

```
echo -n 1 | pike solution.pike
```

Problem: [Sensor Boost](https://adventofcode.com/2019/day/9)
