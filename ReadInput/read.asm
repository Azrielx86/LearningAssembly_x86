global _start

section .bss
num1str        resb   9

section .data
prompt1        db     "Escribe el primer número: "
prompt1_len    equ    $ - prompt1
prompt2        db     "Escribe el segundo número: "
prompt2_len    equ    $ - prompt2

section .text

print:
  push   rax
  push   rdi
  mov    rax,1
  mov    rdi,1
  pop    rdx
  pop    rsi
  syscall
  ret

read:
  push   rax
  push   rdi

  mov    rax,0
  mov    rdi,0
  pop    rdx
  pop    rsi
  syscall

_start:
  mov    rax,prompt1
  mov    rdi,prompt1_len
  call print

  mov    rax,num1str
  mov    rdi,8
  call print

  mov    rax,prompt2
  mov    rdi,prompt2_len
  call print

  mov    rax,60
  mov    rdi,0
  syscall
