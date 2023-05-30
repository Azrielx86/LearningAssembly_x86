LOCALS @@ ; Directiva de TASM necesaria para poder usar etiquetas locales en los procedimientos
title "Tarea 5 - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
; Cadenas de prueba
string1     db     0ADh,"Hola Mundo!",0Ah,0Dh,"$"
string2     db     "1a2b3c4d5e",0Ah,0Dh,"$"
string3     db     "1A2B3C4D5E",0Ah,0Dh,"$"
string4     db     "string.AlternateCase();",0Ah,0Dh,"$"
  .code

alter_char proc tiny     ; Primer prodecdimiento, alterna carácteres entre mayúsculas y minúsculas
  ; Comprueba si es una letra, desde la 'Z' hacia los carácreres menores, y de la 'a' hacia los carácteres mayores.
  cmp      dl,5Ah        ; Compara si el dígito es menor o igual a 'Z'.
  jle      @@to_lower    ; Si es un dígito menor o igual, puede ser una letra mayúscula o un carácter, por lo que más adelante se comprueba el rango de la 'A' a la 'Z'
  cmp      dl,61h        ; Comprueba si el dígito es mayor o igual al valor en ASCII de la 'a'
  jge      @@to_upper    ; Si se cumple la condición, más adelante se comprueba el rango completo de la 'a' a la 'z'

  @@to_upper:            ; Conversión de una letra de minúsculas a mayúsculas.
    cmp      dl,7Ah      ; Comprueba el segundo rango de carácteres, si son mayores al valor ASCII de la 'z', entonces es un carácter fuera del alfabeto, por lo que no realiza ningún cambio
    jg       @@return    ; Salto a la salida de la función
    sub      dl,20h      ; En caso de que esté en el rango de la 'a' y la 'z', resta 20h en hexadecimal para pasar el carácter a mayúsculas.
    jmp      @@return    ; Salto a la salida de la función

  @@to_lower:            ; Conversión de una letra de mayúsculas a minúsculas.
    cmp      dl,41h      ; Comprueba si el carácter está fuera del rango entre la 'A' y la 'Z'.
    jl       @@return    ; Salto al retorno de la función si la condición no se cumple.
    add      dl,20h      ; Suma 20 en hexadecimal para pasar el carácter de mayúsculas a minúsculas.
    jmp      @@return    ; Salto a la salida de la función.

  @@return:              ; Retorno de la función.
    ret
alter_char endp          ; Fin del primer procedimiento.

alternate_case proc tiny ; Procedimiento para iterar una cadena y alternar sus carácteres alfabéticos entre mayúsculas y minúsculas.
  mov      si,0h         ; Establece el índice en cero.
  mov      bx,dx         ; Mueve la dirección del inicio de la cadena a bx.
  @@loop:                ; Primer loop.
    mov      dl,[bx + si]; Mueve el valor de bx + el índice a dl, para obtener el carácter.
    cmp      dl,'$'      ; Comprueba si no es el carácter nulo de la cadena.
    je       @@return    ; Si es el carácter nulo, sale de la función.

    call alter_char      ; Llamada al procedimiento para alternar el carácter entre mayúsclas y minúsculas.
    mov      [bx + si],dl; Modifica el carácter de la cadena original en la base e índice indicados.
    inc      si          ; Incrementa el índice.
    jmp      @@loop      ; Repite el ciclo
  @@return:              ; Retorno de la función.
    mov      dx,bx       ; Retorna la dirección del inicio de la cadena a dx.
    ret                  ; Salida de la función.
alternate_case  endp     ; Fin del procedmimiento.

inicio:                  ; Programa principal
  mov    ax,@data
  mov    ds,ax

  ; Prueba para alternar los carácteres alfabéticos en distintas cadenas.
  lea    dx,[string1]    ; Mueve la dirección en memoria de la cadena 1 a dx.
  call alternate_case    ; Llama a la función para alternar los carácteres.
  mov    ax,0900h        ; Como al final de la función se regresa la dirección de la cadena a dx, se puede realizar una interrupción para imprimir la cadena en pantalla.
  int 21h                ; Se realiza la interrupción.

  lea    dx,[string2]    ; Se repite el proceso para las demás cadenas.
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

salida:               ; Salida del programa.
  mov    ah,04Ch
  xor    al,al
  int 21h
  end inicio
