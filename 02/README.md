# Day 02 - R

This day's solution is in [R][1], a data processing language. It is terribly
unadapted to the day's problem, as it requires mutability and iterative flow
control (not one of R's strengths) as well as 0-based array indices (R's array
indices are 1-based).

To run this day, install R.

Save your input of the day in the file "input.txt", then run:

``shell
R --no-save --slave < solution.r
``

You will get one big number, which is the answer to the first part, and a pair
of numbers, the answer for the second part.


[1]: https://en.wikipedia.org/wiki/R_(programming_language)

Problem: [1202 Program Alarm](https://adventofcode.com/2019/day/2)
