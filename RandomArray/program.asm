section .text
  global _start
_start:
  mov    rax,01h
  mov    rdi,01h
  mov    rsi,message
  mov    rdx,msglen
  syscall

  call   exit
exit:
  mov rax,60
  mov rdi,0
  syscall
section .data
  message    db    "Hello World!",0Ah
  msglen     equ   $ - message
