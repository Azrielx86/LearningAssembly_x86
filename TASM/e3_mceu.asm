title "Ejercicio 3 - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
res1    dw    ?      ; Variable para el primer resultado
res2    dw    ?      ; Variable para el segundo resultado
res3    dw    ?      ; Variable para el tercer resultado
X       dw    0FF7Ch ; Variable X = -132, FF7C en hexadecimal con complemento a dos
Y       dw    120d   ; Variable Y = 120
  .code
inicio:
  mov    ax,@data    ; Se colocan las variables en el segmento de datos
  mov    ds,ax

  mov    ax,[X]      ; Registro ax = X
  add    ax,[Y]      ; ax = ax + Y      => X + Y
  mov    dx,35d      ; registro dx = 35d
  neg    dx          ; Se realiza el complemento a dos de 35, por lo que dx = -35d
  sub    ax,dx       ; ax = ax - dx     => X + Y - (-35)
  add    ax,53d      ; ax = ax + 53d    => X + Y - (-35) + 53
  mov    [res1],ax   ; res1 = ax        => Se almacena el resultado de la operación en res1
                     ; Resultado esperado: -132 + 120 - (-35) +53
                     ;                     = 76 => 4C 

  mov    ax,[res1]   ; ax = res1        => res1
  add    ax,1h       ; ax = res1 + 1    => res1 + 1
  mov    [res2],ax   ; res2 = ax        => Se almacena el resultado de la operación en res2
                     ; Resultado esperado: 4D

  mov    ax,[res1]   ; ax = res1        => res1
  sub    ax,1h       ; ax = ax - 1      => res1 - 1
  mov    [res3],ax   ; res3 = ax        => Se almacena el resultado de la operación en res3
                     ; Resultado esperado: 4B

salida:              ; Salida del programa
  mov    ax,4C00h
  int 21h
  end inicio
