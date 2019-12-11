" Generic IntCode computer

function! s:At(data, index)
  return a:data[a:index]
endfunction

function! s:Set(data, index, value)
  let a:data[a:index] = a:value
endfunction

function! s:Ipow(a, b)
  let l:res = 1
  let l:i = 0
  while l:i < a:b
    let l:res = l:res * a:a
    let l:i += 1
  endwhile
  return l:res
endfunction

function! s:Get_modifier(op, arg_num)
  let l:base = s:Ipow(10, a:arg_num + 1)
  return (a:op / l:base) % 10
endfunction


function! s:Get_index(op, data, pc, rel_base, arg_num)
  let l:mod = s:Get_modifier(a:op, a:arg_num)
  let l:arg_index = a:pc + a:arg_num
  if l:mod == 0
    return s:At(a:data, l:arg_index)
  elseif l:mod == 1
    return l:arg_index
  elseif l:mod == 2
    return a:rel_base + s:At(a:data, l:arg_index)
  else
    echoerr "Unknown mod\n"
  endif
endfunction

function! s:Get_val(op, data, pc, rel_base, arg_num)
  let l:index = s:Get_index(a:op, a:data, a:pc, a:rel_base, a:arg_num)
  return s:At(a:data, l:index)
endfunction

function! s:Bin_op(op, data, pc, rel_base)
  let l:arg1 = s:Get_val(a:op, a:data, a:pc, a:rel_base, 1)
  let l:arg2 = s:Get_val(a:op, a:data, a:pc, a:rel_base, 2)
  let l:dest_index = s:Get_index(a:op, a:data, a:pc, a:rel_base, 3)
  let l:res = 0
  let l:shortop = a:op % 100
  if shortop == 1
    let l:res = l:arg1 + l:arg2
  elseif shortop == 2
    let l:res = l:arg1 * l:arg2
  elseif shortop == 7
    let l:res = l:arg1 < l:arg2 ? 1 : 0
  elseif shortop == 8
    let l:res = l:arg1 == l:arg2 ? 1 : 0
  else
    echoerr "Unknown bin_op\n"
    exit(1)
  endif
  call s:Set(a:data, l:dest_index, l:res)
endfunction

function! s:Jump(op, data, pc, rel_base)
  let l:arg1 = s:Get_val(a:op, a:data, a:pc, a:rel_base, 1)
  let l:arg2 = s:Get_val(a:op, a:data, a:pc, a:rel_base, 2)
  let l:shortop = a:op % 100
  if shortop == 5
    if l:arg1 != 0
      return l:arg2
    endif
  elseif shortop == 6
    if l:arg1 == 0
      return l:arg2
    endif
  else
    echoerr "Unknown jump\n"
  endif
  return a:pc + 3
endfunction

function! s:Write_at(robot, op, data, pc, rel_base)
  let l:arg1 = s:Get_val(a:op, a:data, a:pc, a:rel_base, 1)
  call a:robot.Write(l:arg1)
endfunction

function! s:Read_at(robot, op, data, pc, rel_base)
  let l:index = s:Get_index(a:op, a:data, a:pc, a:rel_base, 1)
  call s:Set(a:data, l:index, a:robot.Read())
endfunction

function! s:Run(data, robot)
  let l:pc = 0
  let l:rel_base = 0
  while 1
    let l:op = s:At(a:data, l:pc)
    let l:shortop = (l:op % 100)
    if (l:shortop == 1 ||
       \l:shortop == 2 ||
       \l:shortop == 7 ||
       \l:shortop == 8)
      call s:Bin_op(l:op, a:data, l:pc, l:rel_base)
      let l:pc += 4
    elseif (l:shortop == 5 ||
           \l:shortop == 6)
      let l:pc = s:Jump(l:op, a:data, l:pc, l:rel_base)
    elseif l:shortop == 3
      call s:Read_at(a:robot, l:op, a:data, l:pc, l:rel_base)
      let l:pc += 2
    elseif l:shortop == 4
      call s:Write_at(a:robot, l:op, a:data, l:pc, l:rel_base)
      let l:pc += 2
    elseif l:shortop == 9
      let l:rel_base += s:Get_val(l:op, a:data, l:pc, l:rel_base, 1)
      let l:pc += 2
    elseif l:shortop == 99
      return
    else
      echoerr "Unknown op: " . l:op . "\n"
      return
    endif
  endwhile
endfunction

function! s:Read_program(filename)
  let l:data = []
  let l:index = 0
  while l:index < 10000
    let l:data = add(l:data, 0)
    let l:index += 1
  endwhile
  let s:Lines = split(readfile(a:filename)[0], ",")
  let l:index = 0
  for s:Line in s:Lines
    let l:data[l:index] = s:Line
    let l:index += 1
  endfor
  return data
endfunction

" Start of Day-11 specific code

let s:robot_class = {
      \"panel": {},
      \"x": 0,
      \"y": 0,
      \"isPainting": 1,
      \"facing": 0
\} " 0=-Y, 1=+X, 2=+Y, 3=-X

function! s:ComputeKey(x, y)
  return 1000 * a:x + a:y
endfunction

function! s:robot_class.GetKey()
  return s:ComputeKey(self.x, self.y)
endfunction

function! s:robot_class.Read()
  let l:key = self.GetKey()
  if has_key(self.panel, l:key)
    return self.panel[l:key]
  else
    return 0
endfunction

function! s:robot_class.Write(val)
  if self.isPainting
    let l:key = self.GetKey()
    if a:val != 0 && a:val != 1
      echoerr "Unknown color"
    else
      let self.panel[l:key] = a:val
    endif
    let self.isPainting = 0
  else
    let self.facing += 2 * a:val - 1
    if self.facing == -1 || self.facing == 3
      let self.facing = 3
      let self.x -= 1
    elseif self.facing == 0 || self.facing == 4
      let self.facing = 0
      let self.y -= 1
    elseif self.facing == 1
      let self.x += 1
    elseif self.facing == 2
      let self.y += 1
    else
      echoerr "Unknow direction"
    endif
    let self.isPainting = 1
  endif
endfunction

function! s:Always_one()
  return 1
endfunction

function! s:Echo(val)
  echo a:val
endfunction

" Given the panel of the robot, create a new buffer with the password printed.
function! s:Print_panel(panel)
  vnew
  let l:y = 0
  while l:y < 20
    let l:x = 0
    let l:line = ""
    while l:x < 80
      let l:key = s:ComputeKey(l:x, l:y)
      if has_key(a:panel, l:key) && a:panel[l:key]
        let l:line = l:line .'█'
      else
        let l:line = l:line .' '
      endif
      let l:x += 1
    endwhile
    call append(l:y, l:line)
    let l:y += 1
  endwhile
endfunction

function! Advent_of_code(filename)
  let l:data = s:Read_program(a:filename)
  let l:robot = copy(s:robot_class)
  call s:Run(copy(l:data), l:robot)
  echo "First solution: " . len(l:robot.panel)
  let l:white_robot = copy(s:robot_class)
  " Note that we need to reset the panel, not just set the first square.
  let l:white_robot.panel = {"0": 1}
  call s:Run(copy(l:data), l:white_robot)
  call s:Print_panel(l:white_robot.panel)
  return 0
endfunction
