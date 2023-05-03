section .text
extern add
extern printf
global _start
default rel
_start:
  mov    rdi,50
  mov    rsi,34
  call add

  push   rbp
  push   rax
  mov    rdi,fmt
  pop    rsi
  mov    rax,0
  call   printf
  pop    rbp

  jmp _exit
_exit:
  mov    rax, 60
  mov    rdi,0h
  syscall
section .data
fmt        db    "Result (50 + 34) = %d",10,0
