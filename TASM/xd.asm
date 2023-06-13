title "Ejercicio"
	.model small
	.386
	.stack 64
	.data
num1 dw 5412h, 0A54Ah, 0C43Fh, 0F321h
num2 dw 0B37Dh, 1267h, 62B7h, 924Eh, 0000h
num3 dw 0FECBh, 4379h, 0B779h, 0E726h, 0000h
.code
inicio:
	mov ax, @data
	mov ds, ax

	mov cx, 4
	xor di, di
	clc
suma:
	mov ax, [num1+di]
	adc [num2+di], ax
	inc di
	inc di
	loop suma
	adc [num2+di],0

	mov cx, 5
	xor di, di
	clc
resta:
	mov ax, [num2+di]
	sbb [num3+di], ax
	inc di
	inc di
	loop resta

salir:
	mov ax, 4C00h
	int 21h
	end inicio
