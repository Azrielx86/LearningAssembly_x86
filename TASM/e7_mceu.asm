title "Ejercicio 7 - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
var1       db    42h
var2       db    58h
strMayor   db   "El primer n",0A3h,"mero es mayor al segundo.",0Ah,0Dh,"$"
strMenor   db   "El segundo n",0A3h,"mero es mayor al primero.",0Ah,0Dh,"$"
strIgual   db   "Los dos n",0A3h,"meros son iguales.",0Ah,0Dh,"$"
  .code
inicio:
  mov    ax,@data
  mov    ds,ax

  xor    ax,ax            ; Establece ax en 0.
  xor    bx,bx            ; Establece bx en 0.
  mov    al,[var1]        ; Mueve el valor de var1 en al.
  mov    bl,[var2]        ; Mueve el valor de var2 en bl;

  cmp    al,bl            ; Compara al y bl
  jbe    menor_ig         ; Si al es menor o igual, el programa se mueve a la segunda comparación
  lea    dx,[strMayor]    ; En caso de que al sea mayor, se almacena en dx la dirección de la cadena strMayor.
  jmp    imprimir         ; El programa se mueve a la parte de la impresión
menor_ig:                 ; Etiqueta para la parte de la comprobación menor o igual.
  cmp    al,bl            ; Se vuelve a comparar al y bl.
  je     igual            ; Si son iguales, el programa se mueve a la parte 
  lea    dx,[strMenor]    ; Si no son iguales, por omisión el primer número es menor, así que se mueve la dirección de la cadena strMenor a dx.
  jmp    imprimir         ; El programa se mueve hacia la parte de la impresión.
igual:                    ; Etiqueta para cuando los números son iguales.
  lea    dx,[strIgual]    ; Si los números son iguales, se mueve la dirección de la cadena strIgual a dx.
imprimir:                 ; Etiqueta para la impresión.
  mov    ax,0900h         ; Se coloca ax en 0900h para imprimir una cadena.
  int 21h                 ; Se realiza la interrupción al sistema.
salida:
  mov    ax,4C00h
  int 21h
  end inicio
