title "Ejercicio 1 - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
  ; Para imprimir los carácteres especiales, se usa el set de caracteres "Code page 437"
linea1 db 0ADh,"Hola!",0Dh,0Ah,"$"
  ; 0Dh - Retorna el cursor al inicio de la línea en DOS
  ; 0Ah - Salto de línea en DOS
  ; $   - Carácter nulo, indica el fin de una cadena
linea2 db "Este es un ejercicio de programaci",0A2h,"n en lenguaje ensamblador.",0Dh,0Ah,"$"
linea3_4 db 0ADh,"Ya s",082h," imprimir en pantalla! =)",0Dh,0Ah,"Fin.",0Dh,0Ah,"$"
  .code 
inicio:
  mov ax, @data
  mov ds, ax

  lea dx, [linea1]
  mov ax, 0900h
  int 21h

  lea dx, [linea2]
  mov ax, 0900h
  int 21h

  lea dx, [linea3_4]
  mov ax, 0900h
  int 21h

salir:
  mov ah, 4Ch
  mov al, 0
  int 21h
  end inicio
