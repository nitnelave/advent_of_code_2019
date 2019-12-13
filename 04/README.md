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

Problem: [Secure Container](https://adventofcode.com/2019/day/4)
