# Day 04 - Prolog

This day is done in Prolog, a logical programming language. The problem lends
itself very well to the language, being a simple constraint solving problem:

To run this solution, you will need to change the input values in the
`solution.pl` file (in `is_value_in_range`), then run the file with a prolog
interpreter (e.g. SWI-Prolog):

```shell
prolog -q -s solution.pl -t main.
```

If you want to play around, just load the file in prolog:

```shell
prolog -s solution.pl
```

Now you can try different queries, like:

```prolog
main.

num_password(N).

num_password2(N).

findall(X, (has_6_digits(X), is_value_between(X, 100000, 100002)), Xs).
```

## Problem: Secure Container

### Part 1

You arrive at the Venus fuel depot only to
discover it's protected by a password. The Elves had written the password on a
sticky note, but someone threw it out.

However, they do remember a few key facts about the password:

 - It is a six-digit number.
 - The value is within the range given in your puzzle input.
 - Two adjacent digits are the same (like 22 in 122345).
 - Going from left to right, the digits never decrease; they only ever increase
   or stay the same (like 111123 or 135679).

Other than the range rule, the following are true:

 - `111111` meets these criteria (double 11, never decreases).
 - `223450` does not meet these criteria (decreasing pair of digits 50).
 - `123789` does not meet these criteria (no double).

How many different passwords within the range given in
your puzzle input meet these criteria?

### Part 2

An Elf just remembered one more important detail: the two
adjacent matching digits are not part of a larger group of matching digits.

Given this additional criterion, but still ignoring the range rule, the
following are now true:

 - `112233` meets these criteria because the digits never decrease and all
   repeated digits are exactly two digits long.
 - `123444` no longer meets the criteria (the repeated 44 is part of a larger
   group of 444).
 - `111122` meets the criteria (even though 1 is repeated more than twice, it
   still contains a double 22).

How many different passwords within the range given in your puzzle input
meet all of the criteria?
