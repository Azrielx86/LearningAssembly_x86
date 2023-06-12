title "Ejercicio 6 - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
max_digitos     equ     4 ; Máximo de dígitos (se establecerá para números de 16 bits).
buffer          db      max_digitos dup(0) ; Buffer de datos para el teclado.
numero          dw      0 ; Variable para almacenar el número convertido.
prompt          db      "Ingresa un n",0A3h,"mero (M",0A0h,"ximo ",max_digitos+30h," d",0A1h,"gitos): ","$"
  .code
inicio:
  mov   ax,@data
  mov   ds,ax

  lea   dx,[prompt]     ; Instrucciones para mostrar el mensaje en pantalla.
  mov   ax,0900h        ; Opción 0900h para imprimir el mensaje en pantalla.
  int 21h               ; Interrupción.

; ========================== Lectura del teclado ===============================
  lea   bx,[buffer]     ; Se la dirección inicial del buffer que leerá el número en bx.
  mov   si,0h           ; El contador si se coloca en 0.
leer_digitos:
  mov   ax,0800h        ; La instrucción 0800h lee una entrada del teclado sin mostrarla en pantalla (echo).
  int 21h               ; Interrupción para leer la entrada del teclado.
  cmp   al,0Dh          ; Se comprueba si la entrada fue la tecla enter.
  je    end_ld          ; Si fue la tecla enter, deja de leer las siguientes entradas.
  
  cmp   al,39h          ; Comprobaciones para verificar que la entrada sea un dígito numérico.
  jg    end_ld          ; Si la entrada no es un dígito, deja de leer los siguientes dígitos.
  cmp   al,30h
  jl    end_ld

  mov   dl,al           ; Se mueve la entrada leída a dl.
  mov   ax,0200h        ; Se imprime el dígito en pantalla con la opción 0200h.
  int 21h

  mov   [bx + si],al    ; Se guarda el dígito en el buffer.

  inc   si              ; Se incrementa si en 1.
  cmp   si,max_digitos  ; Se compara el contador con el máximo de dígitos.
  jl    leer_digitos    ; Si aún no llega al máximo de dígitos, se siguen leyendo los siguientes dígitos.
end_ld:                 ; Etiqueta para el final de la lectura del teclado.
  mov   ax,0200h        ; Se coloca la opción 0200h para imprimir un dígito.
  mov   dl,0Ah
  int 21h
  mov   dl,0Dh
  int 21h               ; Se imprimen el salto de línea y el retorno de carro.

; =========== Conversión del buffer con números a un número decimal ============
  mov   si,0h           ; Se coloca el contador en 0
  mov   cx,10           ; Se coloca cx en 10, para las multiplicaciones
  xor   ax,ax           ; ax se coloca en cero, se usará como acomulador
;=====================================;
; Siguiendo el siguiente ejemplo,     ;
; donde se usa la siguiente fórmula:  ;
; ax = bx + ax * cx                   ;
;                                     ;
; Ejemplo con 1245:                   ;
; 1 + 0   * 10 = 1;                   ;
; 2 + 1   * 10 = 12                   ;
; 4 + 12  * 10 = 124                  ;
; 5 + 124 * 10 = 1245                 ;
;=====================================;
txt2num:
  mov   bl,[buffer + si]; Se mueve a bl el carácter de buffer + si (desplazamiento)
  cmp   bl,0h           ; Se compara si el dígito es un cero
  je    txt2num_end     ; Si el dígito es cero, el programa pasa a la etiqueta indicada para incrementar y comparar el contador

  xor   bx,30h          ; Se convierte el dígito a número decimal.
  mul   cx              ; Se multiplica el acomulador ax por 10.
  add   ax,bx           ; Se suma el número obtenido al acomulador.

txt2num_end:
  inc   si              ; Se incrementa el contador si
  cmp   si,max_digitos  ; Se comprueba si ya se alcanzó el máximo de dígitos
  jl    txt2num         ; Se repite el proceso

; ================= Conversión de decimal a hexadecimal ========================
  mov     [numero],ax   ; Se mueve el número obtenido a ax.
  mov     bp,sp         ; Se mueve la base de la pila al tope de la pila.
  
  mov     bx,16         ; Se establece bx en 16 para la división a 16.
loop_digitos:
  xor     dx,dx         ; Se coloca dx en cero.
  div     bx            ; Se divide ax entre 16
  push    dx            ; Se coloca el residuo en la pila
  cmp     ax,0h         ; Se compara si ax ya es cero
  jne     loop_digitos  ; Se siguen sacando dígitos mientras ax sea distinto de cero.

  mov     ax,0200h      ; Se establece ax en 0200h para imprimir carácteres.
loop_imprimir:          ; Loop para imprimir
  pop     dx            ; Se saca el dígito de la pila
  or      dx,30h        ; Se convierte a carácter
  cmp     dx,3Ah        ; Si el dígito es menor a 3A (carácter A), se imprime directamente
  jl      print         ; Salto a print
  add     dx,07h        ; Se le suma 07h a los dígitos mayores a 9, que corresponden a: A, B, C, D, E y F en hexadecimal.
print:
  int     21h           ; Se imprime el dígito contenido en dx.
  cmp     bp,sp         ; Se compara si ya no hay dígitos en la pila.
  jne     loop_imprimir ; Si aún hay dígitos, se vuelve a repetir el proceso.

  mov     dx,000Ah      ; Impresión del salto de línea y retorno de carro.
  int 21h
  mov     dx,000Dh
  int 21h
  pop     bp

salida:                 ; Salida del programa
  mov    ax,4C00h
  int 21h
  end inicio