debug_print =: ] NB.(1 !: 2) & 2

data_txt =: 1 !: 1 < 'input.txt'
data =: ". }: data_txt  NB. drop the last \n

set_op =: 3 : 0
'list index val' =. y
val index } list
)

bin_op =: 4 : 0
NB. fun bin_op args
'list dest_index val1 val2' =. y
(". ('val1', x, 'val2')) dest_index } list
)

arg_type =: 4 : 0
NB. arg_index arg_type opcode
opcode =. y
power =. (10 & * ^: x) 10
(10 | opcode % power) >= 1
)

arg_val =: 3 : 0
'l opcode arg_index PC' =. y
val =. (arg_index + PC) } l
if. arg_index arg_type opcode
do. val
elseif. 1 do. val } l
end.
)

full_bin_op =: 4 : 0
NB. fun full_bin_op (list;PC) -> (list; PC)
'list PC' =. y
op =. PC } list
dest_index =. (PC+3) } list
v1 =. arg_val (list; op; 1; PC)
v2 =. arg_val (list; op; 2; PC)
((x bin_op (list; dest_index; v1; v2)); PC + 4)
)

add_op =: '+' & full_bin_op
mul_op =: '*' & full_bin_op
lt_op =: '<' & full_bin_op
eq_op =: '=' & full_bin_op

jump_if_eq =: 4 : 0
NB. val jump_if_eq args
'list op PC' =. y
test_val =. arg_val (list; op; 1; PC)
jump_val =. arg_val (list; op; 2; PC)
if. 1 - (x = (test_val < 1))
do. (list; jump_val)
elseif. 1 do. (list; PC + 2)
end.
)

append_output =: 4 : 0
'list PC' =. x
'input output' =. y
input;list;PC;output
)

run_op =: 3 : 0
NB. input run_op (input; list; PC; output) -> (input; list; PC; output)
'input list PC output' =. y
op =. PC } list
debug_print 'PC'; PC; 'OP'; op
select. 100 | op
case. 1 do.
  (add_op (list; PC)) append_output (input; output)
case. 2 do.
  (mul_op (list; PC)) append_output (input; output)
case. 3 do.
  debug_print 'read';'input:';input
  ((}. input); (set_op (list; ((PC+1) } list); ({. input))); (PC+2); output)
case. 4 do.
  debug_print 'write';(((PC + 1) } list)}list)
  (input; list; (PC+2); (((PC + 1) } list)}list))
case. 5 do.
  (1 jump_if_eq (list; op; PC)) append_output (input; output)
case. 6 do.
  (0 jump_if_eq (list; op; PC)) append_output (input; output)
case. 7 do.
  (lt_op (list; PC)) append_output (input; output)
case. 8 do.
  (eq_op (list; PC)) append_output (input; output)
case. 99 do.
  debug_print 'stop'
  (input; list; PC; output)
case. do.
  debug_print 'error'
  assert. 0
end.
)

run_prog =: 3 : '(run_op ^: _) (y; data; 0; 1 $ 0)'

run_seq =: 3 : 0
0 run_seq y
:
full_out =. run_prog (({. y), x)
out =. > {: full_out
if. 1 = # y do. out
elseif. 1 do. out run_seq }. y
end.
)

generate_permutations =: i. @ ! A. i.

run_all_perm =: run_seq " 1 @: generate_permutations

max =: >. /

max_signal =: max @: run_all_perm

all_eq =: 4 : 0
(+/ (x = y)) = # x
)

run_until_signal =: 4 : 0
NB. input_signal run_until_signal args
'input list PC out' =. y
new_input =. input,x
if. 2 < # new_input do. new_input =. input end.
res =. new_input;list;PC;(0$0)
debug_print 'input';(> {. res )
while. 1 = # $ > {: res
do.
  new_res =. run_op res
  debug_print 'res PC'; (> 2 { res); 'new_res PC'; (> 2 { new_res)
  debug_print new_res all_eq res
  if. new_res all_eq res do.
    debug_print 'early return'
    (< out) _1 } res
    return.
  end.
  res =. new_res
end.
res
)

make_amp =: 3 : '(y; data; 0; 0)'

make_array =: make_amp " 0

get_output =: 3 : '> (< _1 _1) { y'

run_array =: 3 : 0
NB. input_signal run_array array
array =. y
out =. get_output array
for_index. i. # array do.
debug_print 'i';index
array =. (out run_until_signal (index { array)) index } array
debug_print 'out2';>{:(index { array)
out =. > (< index,  _1) { array
end.
array
)

run_prog_array =: run_array ^: _

run_perm_array =: run_prog_array @: make_array

run_all_perm_array =: run_perm_array " 1 @: (5 & +) @: generate_permutations

max_array_signal =: 3 : 0
all_perm =. run_all_perm_array y
out =. get_output " 2 all_perm
max out
)

(1 !: 2) & 2 max_signal 5
(1 !: 2) & 2 max_array_signal 5
