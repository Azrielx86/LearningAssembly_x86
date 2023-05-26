title "Tarea 4 - Edgar Ulises Moreno Chalico"
  .model small
  .386
  .stack 64
  .data
num1       dw   352
num2       dw   62
msg_sum    db   "La suma es: ","$"
msg_res    db   "La resta es: ","$"
msg_mul    db   "La multiplicaci",0A2h,"n es: ","$"
msg_coc    db   "El cociente es: ","$"
msg_red    db   "El residuo es: ","$"
msg_op     db   "Operaciones con ","$"
  .code
; Primer procedimiento, imprime un mensaje
; Requiere que en dx ya esté cargada la
; dirección de la cadena a imprimir
print_msg proc near
  mov    ax,0900h         ; Opción 0900h para imprimir una cadena
  int    21h              ; Interrupción para imprimir
  ret                     ; Retorno de la función
print_msg endp            ; Fin de la función

print_ent proc near       ; Función para imprimir un salto de línea y retornar el cursor al inicio de la línea
  mov    ax,0200h         ; Salto de línea
  mov    dl,0Ah
  int    21h

  mov    ax,0200h         ; Retorno de carro
  mov    dl,0Dh
  int    21h
  ret                     ; Retorno de la función
print_ent endp            ; Fin de la función

print_num proc near       ; Función para imprimir un número, requiere que AX tenga el número a imprimir
  push   bp               ; Se guarda el inicio de la pila, ya que en esta función se usará la pila
                          ; Y es necesario "moverla"
  mov    bp,sp            ; Se establece como inicio de la pila el valor del tope de la pila

  mov    bx,10            ; Se guarda en bx 10 para poder ir dividiendo entre 10

  saca_digitos:           ; En el primer loop, se van sacando los dígitos uno a uno
    mov    dx,0h          ; Se coloca dx en 0 para la división de 16 bits
    div    bx             ; Se divide entre bx (10)
    push   dx             ; Se guarda el resíduo (el dígito menos significativo) en la pila
    cmp    ax,0           ; Se compara si ax = 0, es decir que ya se hayan sacado todos los dígitos
    jne    saca_digitos   ; Si aún no se sacan todos los dígitos, repite el loop

  imprime_digitos:        ; Segundo loop que irá imprimiendo los dígitos de la pila
    pop    dx             ; Saca el dígito en la pila
    or     dl,'0'         ; Se le suma el dígito al valor en hexadecimal para 0,
                          ; es equivalente a 48 (0 en ASCII) + dígito, lo que da
                          ; el valor del dígito en ASCII
    mov    ax,0200h       ; Se coloca la opción 0200h para la impresión de un dígito
    int    21h            ; Como al hacer el pop el dígito se encontraba en dx, ya se puede hacer la interrupción
    cmp    bp,sp          ; Compara si el puntero de la base de la pila = puntero del tope de la pila, es decir, que
                          ; ya se hayan acabado los dígitos
    jne    imprime_digitos; En caso de que aún queden dígitos, se siguen imprimiendo en el loop.

  pop    bp               ; Retorna el puntero a la base de la pila previo a la llamada de esta función
  ret                     ; Salida de la función
print_num endp            ; Fin de la función

inicio:
  mov    ax,@data         ; Se coloca el segmento de datos en ds mediante ax
  mov    ds,ax

  ; Mensaje principal para mostrar la operación
  lea    dx,[msg_op]      ; Se prepara dx para llamar a la función (usándolo como parámetro)
  call   print_msg        ; Se llama a la función para imprimir un mensaje.
  mov    ax,[num1]        ; Se prepara ax para llamar a la función (usándolo como parámetro)
  call   print_num        ; Llamada a la función para imprimir el primer dígito
  mov    ax,0200h
  mov    dl,' '           ; Impresiones de carácteres para completar el mensaje
  int    21h
  mov    ax,0200h
  mov    dl,'y'
  int    21h
  mov    ax,0200h
  mov    dl,' '
  int    21h
  mov    ax,[num2]
  call   print_num        ; Impresión del segundo número
  call   print_ent

  ; Suma
  lea    dx,[msg_sum]     ; Se prepara el mensaje de la suma para la impresión en pantalla
  call   print_msg        ; Se llama a la función para imprimir el mensaje
  mov    ax,[num1]        ; Se realiza la suma
  add    ax,[num2]
  call   print_num        ; Se imprime el resultado
  call   print_ent        ; Se imprime el salto de línea

  ; Resta, se realiza un proceso similar que para la suma
  lea    dx,[msg_res]
  call   print_msg
  mov    ax,[num1]
  sub    ax,[num2]
  call   print_num
  call   print_ent

  ; Multiplicación, se realiza un proceso similar para mostrar el resultado
  lea   dx,[msg_mul]
  call  print_msg
  mov   ax,[num1]
  mov   bx,[num2]
  mul   bx
  call  print_num
  call  print_ent

  ; Cociente y residuo
  lea   dx,[msg_coc]     ; Se prepara el mensaje del cociente en dx
  call  print_msg        ; Se imprime en pantalla el mensaje para el cociente
  mov   ax,[num1]
  mov   bx,[num2]
  xor   dx,dx            ; Se coloca dx en 0 para la división
  div   bx               ; Se divide ax / bx
  push  dx               ; Se guarda el valor de
  
  call  print_num        ; En ax se encuentra el cociente, así que solo se llama la función para imprimir un número
  call  print_ent        ; Se imprime el salto de línea

  lea   dx,[msg_red]     ; Se prepara el mensaje para el residuo
  call  print_msg        ; Se imprime el mensaje en pantalla
  pop   ax               ; Se saca el valor del residuo que estaba en la pila
  call  print_num        ; Se imprime el resultado en pantalla
  call  print_ent        ; Se imprime el salto de línea
salida:                  ; Salida del programa
  mov    ax,4C00h
  int 21h
  end inicio
