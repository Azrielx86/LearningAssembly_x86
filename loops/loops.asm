section .text
  global _start

_start:
  mov    rbp,0

lp:
  inc    rbp
  push   rbp

  mov    rax,1
  mov    rdi,1
  lea    rsi,[num]
  mov    rdx,1
  syscall

  mov    rax,[num]
  add    rax,1
  mov    [num],rax
  pop    rbp

  cmp    rbp,10
  jl     lp

  mov    rax,1
  mov    rdi,1
  lea    rsi,nwl
  mov    rdx,1
  syscall

  call _exit

_exit:
  mov    rax,60
  mov    rdi,0
  syscall

section .data
num    db    '0'
nwl    db    0Ah
