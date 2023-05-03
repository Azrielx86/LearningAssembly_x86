  section .text
global _start
_start:
    ; Muestra el mensaje que se escribirá en el archivo
    mov    rax,01h       ; sys_write, llamada 1 a Linux
    mov    rdi,01h       ; Salida a STDOUT (1) (STDIN -> 0, STDERR -> 2)
    mov    rsi,message   ; mensaje que se va a imprimir
    mov    rdx,msglen    ; longitud del mensaje
    syscall

    ; Creación del archivo de texto
    mov    rax,55h       ; sys_creat, llamada 85 a Linux
    mov    rdi,filepath  ; ruta del archivo que se escribirá
    mov    rsi,644o      ; Permisos de acceso 
                         ; 6 -> lectura y escritura para el usuario
                         ; 4 -> lectura para el grupo
                         ; 4 -> lectura para otros
                         ; chmod funciona en octal
                         ; Para más información: chmod Linux
    syscall

    ; Apertura del archivo de texto
    mov    rax,02h       ; sys_open, llamada 2 a Linux
    mov    rdi,filepath  ; Ruta del archivo
    mov    rsi,02h       ; flags, 02 corresponde a lectura y escritura (O_WRONLY)
    mov    rdx,644o      ; Permisos de acceso al archivo
    syscall              ; Al ejecutar la llamada al sistema, se retorna un descriptor del archivo
                         ; que se guarda en rax, o el error si no se puede abrir

    cmp rax,0            ; Comprueba que se haya abierto correctamente
    jl     _error        ; Si no se puede abrir, sale con error 1

    ; Escritura al archivo de texto
    push   rax           ; Mueve el descriptor del archivo a la pila
    mov    rax,01h       ; sys_write, llamada 1 al sistema
    pop    rdi           ; Saca el descriptor del archivo de la pila y lo guarda en rdi como argumento para sys_write
    mov    rsi,message   ; Mensaje que se escribirá
    mov    rdx,msglen    ; Longitud del mensaje
    syscall

    ; Cerrado del archivo
    push   rax           ; Se mueve el descriptor del archivo al tope de la pila
    mov    rax,3h        ; sys_close, llamada 3 a Linux
    pop    rdi           ; Se coloca el descriptor del archivo almacenado en la pila en rdi como argumento para sys_close
    syscall
    
    ; Salida del programa
    jmp _exit            ; Sale del programa

_exit:
    mov    rax,3Ch       ; sys_exit, llamada 60 a Linux
    mov    rdi,0h        ; Código de salida, 0 si no hubo errores
    syscall

_error:
    mov    rax,3Ch
    mov    rdi,01h       ; Código de salida, 1 si hubo errores
    syscall

  section .data
filepath    db    "archivo.txt",0
message     db    "Hola mundo desde un archivo creado por un programa en ensamblador x86_64!",0ah
msglen      equ    $ - message
