title "Ejercicio 6"
  .model small
  .386
  .stack 64
  .data
mensaje    db    "Hola Mundo!",0Ah,0Dh,"$"
  .code
inicio:
  mov    ax,@data
  mov    ds,ax

  lea    dx,[mensaje]   ; Se guarda en dx la dirección del inicio de la cadena de texto.
  mov    cx,20          ; Se establece el registro cx en 20, ya que será el contador del loop.
imprimir:               ; Etiqueta para el loop para imprimir.
  mov    ax,0900h       ; Se establece ax en 0900h para posteriormente hacer la interrupción y mostrar la cadena en pantalla.
  int 21h               ; Se realiza la interrupción al sistema.
  loop imprimir         ; Se repite el loop hasta que cx llegue a cero.
  
salida:
  mov    ah,4Ch
  xor    al,al
  int 21h
  end inicio
