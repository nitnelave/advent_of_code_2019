; layer index
>
; min # of 0
>
; product of #1 * #2
>
; current # of 0; 1; 2
>>>

; setup the loop over a layer: 25 * 6 = 5 * 5 * 6
>
+++++
[
  -
  >+++++
  [
    -
    <<++++++>>
  ]
  <
]
<

; copy the layer number to the current min of 0
[-<<<<+<+>>>>>]<<<<[->>>>+<<<<]>>>>

; read the next character (to detect the EOF)
>>,+
; loop to read each layer
[
  -
  <<
  ; move the layer size to the next 2 cells; skipping the cell where we read
  [->+>>+<<<]
  ; then move it back
  >>>[-<<<+>>>]
  ; move to the new copy; so we can start the loop
  <<
  ; for each pixel in the layer
  [
    ; move to the read character
    >
    ; remove 48 = 8*6
    >++++++++[-<------>]<
    ; values can be 0; 1 or 2: move right by that amount; clearing the cell
    [-[->]>]
    ; move back to the reading cell: after the counts of 0/1/2; it should be the
    ; first cell at 0; if we decrease the loop counter for the layer at the end
    <<<<<+>>>[>]
    ; read the next pixel; for the next iteration
    ,
    ; move back to the loop counter and decrement
    <-
  ]
  ; increment the layer counter
  <<<<<<<+
  ; copy the min number of 0 to read + 5
  >[->>>>>>>>>>>>+>+<<<<<<<<<<<<<]>>>>>>>>>>>>>[-<<<<<<<<<<<<<+>>>>>>>>>>>>>]
  ; copy the current number of 0 to read + 4
  <<<<<<<<<<<[->>>>>>>>>+>>+<<<<<<<<<<<]>>>>>>>>>>>[-<<<<<<<<<<<+>>>>>>>>>>>]
  ; put a 1 at read + 2
  <<<<+
  ; move to read + 4
  >>
  ; handle the case where they're both 0
  +>+<
  ; count down until one of them reaches 0; we'll be at read + 4 if we need
  ; to update
  [->-[>]<<]
  ; zero the marker if we don't need to update
  <[-]
  ; do the update
  <[-
    ; zero the cells we were comparing then return to read + 2
    >>[-]>[-]<<<

    ; move #1 and #2 to read +3 and 2
    <<<<<<[->>>>>>+<<<<<<]
    >[->>>>>>+<<<<<<]
    ; move to read + 3
    >>>>>>
    ; multiply 2 and 3
    [-
      <[->>+>+<<<]>>>[-<<<+>>>]<<<
      >
    ]
    ; clear 3rd cell; move the result to the 3rd cell
    <<<<<<<<<[-]>>>>>>>>>>
    [-<<<<<<<<<<+>>>>>>>>>>]

    ; clear the min num of 0; write our own
    <<<<<<<<<<<[-]>>[-<<+>>]

    ; move to read + 1
    >>>>>>
  ]
  ; clear everything
  >[-]>[-]>[-]>[-]
  ; clear the digit counts
  <<<<<<<<[-]<[-]<[-]
  ; move to the read character; as it's our stopping criterion
  >>>>>
  +
]

<<<<<<

[->>>>>>>>>>+<<<<<<<<<<]>>>>>>>>>>

;copy cell to workspace and back
[>>+>+<<<-]>>>
[<<<+>>>-]<<+>
[<->[ ;while value exists
   >++++++++++< ;make a 10
   [->-[>+>>]>[+[-<+>]>+>>]<<<<<] ;divide value by 10
   >[-] ;dont need this cell
   ++++++++[<++++++>-] ;add 48 to remainder
   >[<<+>>-] ;store the remainder
   >[<<+>>-] ;get next value
   <<
]>]
<[- ;else need to make a zero
   >>++++++++[<++++++>-]
]
;print and clear each stored remainder in reverse
<[.[-]<]<

