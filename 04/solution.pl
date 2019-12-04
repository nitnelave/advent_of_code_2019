/* X is a password if:
 * - It has 6 digits.
 * - When representing the digits, the value is between the bounds of the problem
 *   input.
 * - Each digit is bigger or equal to the previous one.
 * - There are at least 2 (consecutive) equal digits.
 *
 * The commas (",") mean "and". To write "or", we could have used a semi-colon
 * (";").
 *
 * We represent the password as a list of numbers, of length 6.
 */
password(X) :-
  has_6_digits(X),
  is_value_in_range(X),
  digits_are_increasing(X),
  has_2_equal_consecutive_digits(X).

is_value_in_range(X) :- is_value_between(X, 134564, 585159).

/* X has 6 digits if it is a list of length 6, and each element is a digit. */
has_6_digits(X) :-
  length(X, 6),
  elements_are_digits(X).

/* Here, we use pattern matching for this rule. If we can match the argument
 * with the empty list, the first rule (well, fact) is used. Otherwise, we try
 * to match with the second rule. */
/* In an empty list, all the elements are digits.
 * Note that this is not technically a rule, it is a fact: it is true that in
 * an empty list, the elements are digits. */
elements_are_digits([]).
/* If we have more than one element, we check that the first element is a
 * number between 0 and 9, then that the rest of the elements are digits. */
elements_are_digits([X1 | Tail]) :-
  between(0, 9, X1),
  elements_are_digits(Tail).

is_value_between(X, Min, Max) :-
  /* Convert X from a list of digits to a number (like atoi in C).
   * Note that there are no functions in prolog, only relations. Instead of
   * writing X = square(15), you would write square(15, X), i.e.
   * "it is true that X is the square of 15".
   * Here we're asserting that XVal is the value of X. */
  value_of(X, XVal),
  between(Min, Max, XVal).

/* Convert to a version with accumulator. */
value_of(X, Val) :- value_of_rec(X, 0, Val).

/* The value of an empty list is 0, so the result is just the accumulator.
 * Note that we have to use "is" to resolve the expression into a number. */
value_of_rec([], Acc, Val) :- Val is Acc.
/* Classic recursion with accumulator, we propagate the Val to propagate the
 * constraint (i.e. the "return value" of the "function").
 * Example flow:
 *   value_of_rec([1, 2, 3], 0, Val) :-
 *     value_of_rec([2, 3], 1, Val) :-
 *       value_of_rec([3], 12, Val) :-
 *         value_of_rec([], 123, Val) :-
 *           Val is 123.
 */
value_of_rec([X1 | Tail], Acc, Val) :- value_of_rec(Tail, 10 * Acc + X1, Val).

/* Check that each digit is bigger than the previous one. */
digits_are_increasing([_]).
/* Note that we unpack both first elements of the list. */
digits_are_increasing([X1, X2 | Tail]) :-
  X1 =< X2,
  digits_are_increasing([X2 | Tail]).

/* This rule clearly does not accept all inputs: if all the digits are
 * different, we end up trying to call it with the empty list, which matches
 * nothing. That is not an error: not matching means "False". */
has_2_equal_consecutive_digits([X1, X1 | _]).
has_2_equal_consecutive_digits([_ | Tail]) :- has_2_equal_consecutive_digits(Tail).

/* Number of valid passwords is the length of the list of valid passwords.
 * This a possible top-level entrypoint: it is simply called like so:
 *     num_password(P).
 * Which will print:
 *     P = 1234
 *     true.
 * It means "P is a variable. Can you find values for my variables such that
 * num_password(P) holds?" */
num_password(N) :-
  /* Xs is the set of X for which password(X) holds. */
  setof(X, password(X), Xs),
  /* The length of Xs is equal to N. */
  length(Xs, N).

/* Second problem: there must be doubled digits that are not part of a larger
 * group (of 3 or more repeated digits). */
password2(X) :-
  has_6_digits(X),
  is_value_in_range(X),
  digits_are_increasing(X),
  has_2_equal_consecutive_digits_not_in_group(X).

/* Are the first 2 digits their own group? Otherwise, start the recursive
 * version. */
has_2_equal_consecutive_digits_not_in_group([X1, X1, X2 | _]) :- X1 \= X2.
has_2_equal_consecutive_digits_not_in_group(X) :-
  has_2_equal_consecutive_digits_not_in_group_rec(X).

/* Ends with a 2 digit group. */
has_2_equal_consecutive_digits_not_in_group_rec([X1, X2, X2]) :- X1 \= X2.
/* Group in the middle. */
has_2_equal_consecutive_digits_not_in_group_rec([X1, X2, X2, X3 | _]) :-
  X1 \= X2,
  X2 \= X3.
/* Default, recurse down. */
has_2_equal_consecutive_digits_not_in_group_rec([_ | Tail]) :-
  has_2_equal_consecutive_digits_not_in_group_rec(Tail).

/* Solution to the second part. */
num_password2(N) :-
  setof(X, password2(X), Xs),
  length(Xs, N).

/* Compute both parts and print them.
 * This is simply called like so:
 *     main.
 */
main:-
  num_password(N),
  write(["First part", N]),
  nl,
  num_password2(N2),
  write(["Second part", N2]),
  nl.
