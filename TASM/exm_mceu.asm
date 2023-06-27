title "Segundo Examen Parcial - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
u           db    ?
v           db    ?
result      dw    ?
strMayor    db    "El primer n",0A3h,"mero es mayor al segundo",0Ah,0Dh,"$"
strMenor    db    "El primer n",0A3h,"mero es menor al segundo",0Ah,0Dh,"$"
strIgual    db    "Ambos n",0A3h,"meros son iguales",0Ah,0Dh,"$"
strResult   db    "Resultado: ","$"
strPrompt1  db    "Ingresa el primer n",0A3h,"mero: ","$"
strPrompt2  db    "Ingresa el segundo n",0A3h,"mero: ","$"
  .code
read_num proc tiny ; Procedimiento para leer los números
  mov   ax,0800h
  int 21h
  cmp   al,30h
  jb    salida
  cmp   al,39h
  ja    salida
  mov   dl,al
  push  ax
  mov   ax,0200h
  int   21h
  mov   dl,0Dh
  int 21h
  mov   dl,0Ah
  int 21h

  pop   ax
  xor   al,30h
  ret
read_num endp
inicio:
  mov     ax,@data
  mov     ds,ax

  lea     dx,[strPrompt1]
  mov     ax,0900h
  int 21h
  call    read_num
  mov     [u],al

  lea     dx,[strPrompt2]
  mov     ax,0900h
  int 21h
  call    read_num
  mov     [v],al

  xor     ax,ax
  xor     bx,bx
  mov     al,[u]
  mov     bl,[v]
  
  cmp     al,bl
  jle     n_menor
; ------------------------------------------------------------------------------ u > v
  lea     dx,[strMayor]
  push    dx
; ==================================================================== Operación
; 3 * v * v
  mov     ax,3d
  xor     bh,bh
  mov     bl,[v]
  mul     bx
  mul     bx
  push    ax

; 400 / u
  mov     ax,400d
  xor     bh,bh
  mov     bl,[u]
  xor     dx,dx
  div     bx
  push    ax

; 36 * v
  mov     ax,36d
  xor     bh,bh
  mov     bl,[v]
  mul     bx
  push    ax

  pop     cx
  pop     bx
  pop     ax

  add     ax,bx
  sub     ax,cx
  mov     [result],ax

; ==================================================================== Operación
  jmp     imprimir
n_menor:
  cmp     al,bl
  je      n_igual
; ------------------------------------------------------------------------------ u < v
  lea     dx,[strMenor]
  push    dx
; ================================================================== factorial u
  xor     bh,bh
  mov     bl,[u]
  cmp     bx,1h
  je      end_fact
  mov     ax,1h
loop_factorial:
  mul     bx
  dec     bx
  cmp     bx,1h
  jge     loop_factorial
end_fact:
  mov     [result],ax
; ================================================================== factorial u
  jmp     imprimir
n_igual:
; ------------------------------------------------------------------------------ u = v
  lea     dx,[strIgual]
  push    dx
; =================================================================== result = 1
  mov     ax,1h
  neg     ax
  mov     [result],ax
; =================================================================== result = 1

imprimir:
  pop     dx
  mov     ax,0900h
  int 21h
  lea     dx,[strResult]
  int 21h

  mov     ax,[result]
  cmp     ax,0h
  jge     no_neg
  mov     dx,'-'
  push    ax
  mov     ax,0200h
  int 21h
  pop     ax
  neg     ax
no_neg: ; Si el número no es negativo, no se imprime el signo menos y se hace el complemento a dos
  mov     bx,10d
  mov     bp,sp
loop_digitos:
  xor     dx,dx
  div     bx
  push    dx
  cmp     ax,0h
  jne     loop_digitos

  mov     ax,0200h
loop_imprimir:
  pop     dx
  or      dx,30h
  int 21h
  cmp     bp,sp
  jne     loop_imprimir

  mov     dx,0Dh
  int 21h
  mov     dx,0Ah
  int 21h

salida:
  mov    ax,4C00h
  int 21h
  end inicio