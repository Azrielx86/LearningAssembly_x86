title "Ejercicio 2 - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
  .code
inicio:
  mov ax,@data
  mov ds,ax

  mov ax,43ABh
  mov bx,0EDF3h
  mov cx,0001h
  mov dx,1000h

  ; Se colocan los valores de dx y cx en pila
  push dx
  push cx
  ; AX a CX
  mov cx,ax
  ; BX a DX
  mov dx,bx
  ; CX a BX
  pop bx ; El valor de cx está en el tope de la pila, así que se hace un pop y se guarda en bx 
  ; DX a AX
  pop ax ; El valor de dx está en el tope de la pila, se hace un pop y se almacena en ax

salir:
  mov ah, 4Ch
  mov al, 0
  int 21h
  end inicio
  
