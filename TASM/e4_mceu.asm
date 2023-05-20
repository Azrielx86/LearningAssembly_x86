title "Ejercicio 4 - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
x    dw    ?
y    dw    ?
z    dw    ?
  .code
inicio:
  mov    ax,@data
  mov    ds,ax

  mov    [x],60d
  mov    [y],162d

  ; z = 6*x*x-12*y/5-x*y+15*x-3000
  ; Salida de Python: 9392
  ; (6*x*x)-((12*y)/5)-(x*y)+(15*x)-3000

  ; (6*x*x)
  ; mov     ax,6d
  imul    ax,[x],6
  imul    ax,[x]
  push    ax

  ; (12*y)/5
  mov     ax,12d
  mul     [y]
  mov     bx,5d
  div     bx
  push    ax

  ; (x*y)
  mov     ax,[x]
  mul     [y]
  push    ax

  ; (15*x)
  ; mov     ax,15d
  ; mul     [x]
  imul    ax,[x],15d
  push    ax
 
  ; (6*x*x)-((12*y)/5)-(x*y)+(15*x)-3000
  pop     ax
  pop     bx
  sub     ax,bx
  pop     bx
  sub     ax,bx
  pop     bx
  add     ax,bx
  sub     ax,3000d

salida:
  mov    ax,4C00h
  int 21h
  end inicio
