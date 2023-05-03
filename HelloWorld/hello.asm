global _start

  section .text
_start:
    mov        rax,1h
    mov        rdi,1h
    mov        rsi,message
    mov        rdx,msglen
    syscall

    mov        rax,3Ch
    mov        rdi,0h
    syscall
  section .data
message    db    "Hello World!",0ah
msglen     equ   $ - message
