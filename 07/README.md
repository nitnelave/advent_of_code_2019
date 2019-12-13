# Day 07 -- J

Today's language was J. I picked a saturday for this, because the language
seemed complex, and I could feel that it would take some time.

I have since developed strong feelings about this language, but I restrain from
expressing them in case children read this.

J is the successor of APL, with the main contribution being that they use
cryptic ASCII digraphs instead of cryptic unicode symbols.

J is a language that seems to be made to elegantly express functions using
"tacit programming", i.e. declaring a function without mentioning its
arguments. For instance, `+` is a built-in function for addition. `/` is the
built-in for left-fold, leading to the definition `+/` that sums up its
argument via left-fold (in other words: `f x = +/ x`).

Average can be written `+/ % #` (translated: `f x = (+/ x) % (# x)` with `%`
being the division and `#` the length of the list). We can increase the
difficulty until we get to write "pearls" like the following definition:

```
quicksort=: (($:@(<#[), (=#[), $:@(>#[)) ({~ ?@#)) ^: (1<#)
```

I will not attempt to explain this in order to keep my frail sanity for a while
longer.

The language has wonderful features, among which we find:
 - Run-time type errors
 - Cryptic errors (`domain error`, `rank error`, ...)
 - Automatic removal of debug prints when they contain an error
 - Usage of the full range of ASCII to express the many built-ins
 - Language opinionated towards tacit programming, which becomes near
   impossible when dealing with function of more than 2 arguments
 - Monochrome syntax coloring
 - REPL without prompt for better focus
 - No confusing options to the interpreter (no options at all)
 - No toxic member in the community (no community at all)

If, for some reason, you don't believe that I wrote a fully functional program
in J, feel free to save your input for the day in a file `input.txt` next to
`solution.j`, then install J and run `ijconsole solution.j`. You should see the
answers to both parts appear on the screen. Then you have to press Ctrl-D to
quit the interpreter, because you can't tell it to just run a script. You might
want to burn your computer after that, just in case.

Problem: [Amplification Circuit](https://adventofcode.com/2019/day/7)
