title "Ejercicio 6 - Moreno Chalico Edgar Ulises"
  .model small
  .386
  .stack 64
  .data
cadena    db    0ADh,"Hola Mundo!",0Ah,0Dh,"$"
  .code
inicio:
  mov    ax,@data
  mov    ds,ax

  mov    cx,20          ; Se establece el registro cx en 20, ya que será el contador del loop.
  lea    dx,[cadena]    ; Se guarda en dx la dirección del inicio de la cadena de texto.
loop_imprimir:          ; Etiqueta para el loop para imprimir.
  mov    ax,0900h       ; Se establece ax en 0900h para posteriormente hacer la interrupción y mostrar la cadena en pantalla.
  int 21h               ; Se realiza la interrupción al sistema.
  loop loop_imprimir    ; Se repite el loop hasta que cx llegue a cero.
  
salida:
  mov    ax,4C00h
  int 21h
  end inicio
