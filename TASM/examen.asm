LOCALS @@
title "Programa Examen - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
u          db   ?
v          db   ?
result     dw   ? ; Ya que en factorial se pueden obtener resultados mayores a 255, se usará resultado como variable de 16 bits
strMayor   db   "El primer n",0A3h,"mero es mayor al segundo.",0Ah,0Dh,"$"
strMenor   db   "El primer n",0A3h,"mero es menor al segundo.",0Ah,0Dh,"$"
strIgual   db   "Los dos n",0A3h,"meros son iguales.",0Ah,0Dh,"$"
strResult  db   "Resultado: ","$"
  .code
leer_numero proc near
  mov   ax,0800h
  int 21h
  
  cmp   al,39h
  jg    salida
  cmp   al,30h
  jl    salida
  
  push  ax
  mov   dl,al
  mov   ax,0200h
  int 21h
  mov   dl,0Ah
  int 21h
  mov   dl,0Dh
  int 21h
  pop   ax
  xor   al,30h
  ret
leer_numero endp

factorial proc near ; n se para por ax
  cmp   ax,01h
  je    @@salir_f
  mov   bx,ax
  mov   ax,01h
@@loop_fact:
  mul   bx
  dec   bx
  cmp   bx,1h
  jge   @@loop_fact
@@salir_f:
  ret
factorial endp

print_num proc near
  push  bp
  mov   bp,sp
  mov   bx,10
@@saca_digitos:
  xor   dx,dx
  div   bx
  push  dx
  cmp   ax,0
  jne   @@saca_digitos
@@imprime_digitos:
  pop   dx
  or    dl,'0'
  mov   ax,0200h
  int   21h
  cmp   bp,sp
  jne   @@imprime_digitos
  pop   bp
  ret
print_num endp            

inicio:
  mov   ax,@data
  mov   ds,ax

  call  leer_numero ; por ax se retornará el número ya en decimal
  mov   [u],al      ; Se copia a la variable

  call leer_numero
  mov   [v],al

  xor   ax,ax
  xor   bx,bx
  mov   al,[u]
  mov   bl,[v]
; ===== Comparación de los números
  cmp   al,bl
  jbe   min
; u > v
  lea   dx,[strMayor]
  push  dx

  ; operacions
  ; 3 * v * v
  xor   ax,ax
  mov   al,[v]
  mul   ax
  mov   bx,3h
  mul   bx
  push  ax
  ; 400 / u
  xor   dx,dx
  mov   ax,400d
  xor   bx,bx
  mov   bl,[u]
  div   bx
  push  ax
  ; 36 * v
  mov   ax,36d
  xor   bx,bx
  mov   bl,[v]
  mul   bx
  mov   cx,ax
  pop   bx
  pop   ax

  add   ax,bx
  sub   ax,cx
  mov   [result],ax
  jmp   imprimir
min: ; Sección para comparar menor o igual
  cmp   al,bl
  je    nequ
; u < v
  lea   dx,[strMenor]
  push  dx
  xor   ah,ah
  mov   al,[u]
  call  factorial
  mov   [result],ax
  jmp   imprimir
nequ: ; Si son iguales, se guarda -1 en result
; u = v
  lea   dx,[strIgual]
  push  dx
  mov   ax,01h
  neg   ax
  mov   [result],ax

; ==== Muestra de los resultados
imprimir:
  pop   dx
  mov   ax,0900h
  int 21h
  lea   dx,[strResult]
  int 21h

  mov   ax,[result]
  cmp   ax,0h
  jl    neg_res

  call  print_num
  jmp   final
neg_res: ; para numeros negativos
  mov   ax,0200h
  mov   dl,'-'
  int   21h
  mov   ax,[result]
  neg   ax
  call  print_num
final:
  mov   dl,0Ah
  int 21h
  mov   dl,0Dh
  int 21h
salida:
  mov   ax,4C00h
  int 21h
  end inicio