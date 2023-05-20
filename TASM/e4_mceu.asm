title "Ejercicio 4 - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
x         dw    ?
y         dw    ?
z         dw    ?
result    dw    ?
  .code
inicio:
  mov    ax,@data
  mov    ds,ax

  mov    [x],60d
  mov    [y],162d

  ; z = 6*x*x-12*y/5-x*y+15*x-3000
  ; Salida de Python: 9392
  ; El ejercicio se resolverá con el orden de operadores
  ; comúnmente usados en los lenguajes de programación de alto nivel,
  ; es decir que los operadores se evaluarán hacia la derecha, operando
  ; primero multiplicaciones y divisiones, posteriormente sumas y restas.
  ; Por lo que la operación queda de la siguiente manera:
  ; (6*x*x)-(12*y/5)-(x*y)+(15*x)-3000

  ; Se realizan multiplicaciones y divisiones
  ; (6*x*x)
  imul    ax,[x],6     ; Con imul se multiplica x*6 y el resultado se almacena en ax
  imul    ax,[x]       ; Se multiplica ax * x, y el resultado se almacena en ax
  push    ax           ; Se guarda el resultado en la pila

  ; (12*y)/5
  mov     ax,12d       ; Se mueve 12 al registro ax
  mul     [y]          ; Se multiplica ax * y, y se almacena el resultado en ax
  mov     cx,5d        ; Se almacena 5 en cx
  div     cx           ; Se divide ax entre cx
  push    ax           ; Se almacena el resultado en la pila

  ; (x*y)
  mov     ax,[x]       ; Se mueve x al registro ax
  mul     [y]          ; Se multiplica ax * y, y se almacena el resultado en ax
  push    ax           ; Se almacena el resultado en la pila

  ; (15*x)
  imul    ax,[x],15d   ; Se multiplica x * 15 y se almacena el resultado en ax
  push    ax           ; Se almacena el resultado en la pila
 
  ; (6*x*x)-((12*y)/5)-(x*y)+(15*x)-3000
  ; Se realizan las sumas
  pop     ax           ; Se mueve el valor del tope de la pila (6*x*x) a ax
  pop     bx           ; Se mueve el valor del tope de la pila (12*y/5) a bx
  sub     ax,bx        ; Se resta ax - bx
  pop     bx           ; Se mueve el valor del tope de la pila (x*y) a bx
  sub     ax,bx        ; Se resta ax - bx
  pop     bx           ; Se mueve el valor del tope de la pila (15*x) a bx
  add     ax,bx        ; Se suma ax - bx
  sub     ax,3000d     ; Se resta ax - 3000

  mov     [result],ax  ; Se guarda el resultado calculado en ax en la variable result

  ; Resultado obtenido: 24B0h -> 9392

salida:                ; Salida del programa
  mov    ax,4C00h
  int 21h
  end inicio
