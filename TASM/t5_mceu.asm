LOCALS @@
title ""
  .model small
  .386
  .stack 64
  .data
string1     db     0ADh,"Hola Mundo!",0Ah,0Dh,"$"
string2     db     "1a2b3c4d5e",0Ah,0Dh,"$"
string3     db     "String.ToAlternatingCase",0Ah,0Dh,"$"
string4     db     "hello WORLD",0Ah,0Dh,"$"
  .code

up_or_low proc tiny
  push     bp
  mov      bp,sp

  ; Comprueba si no es un dígito
  cmp      dl,005Ah
  jle      @@to_lower

  cmp      dl,0061h
  jge      @@to_upper

  @@to_upper:
    cmp      dl,007Ah
    jg       @@return
    sub      dl,0020h
    jmp      @@return

  @@to_lower:
    cmp      dl,0041h
    jl       @@return
    add      dl,0020h
    jmp      @@return

  @@return:
    pop      bp
    ret
up_or_low endp

alternate_case proc tiny
  mov      si,0h
  mov      bx,dx
  @@loop:
    mov      dl,[bx + si]
    cmp      dl,'$'
    je       @@return

    call up_or_low
    mov      [bx + si],dl
    ; mov      ax,0200h
    ; int 21h
    inc      si
    jmp      @@loop
  @@return:
    mov      dx,bx
    ret
alternate_case  endp

inicio:
  mov    ax,@data
  mov    ds,ax

  lea    dx,[string1]
  call alternate_case
  mov    ax,0900h
  int 21h

  lea    dx,[string2]
  call alternate_case
  mov    ax,0900h
  int 21h

  lea    dx,[string3]
  call alternate_case
  mov    ax,0900h
  int 21h

  lea    dx,[string4]
  call alternate_case
  mov    ax,0900h
  int 21h

salida:
  mov    ax,4C00h
  int 21h
  end inicio
