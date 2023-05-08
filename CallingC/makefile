all: add_asm

program.o:  program.asm
		nasm -f elf64 program.asm

add.o:  add.c
		gcc add.c -c

add_asm: program.o add.o
		ld -o add_asm add.o program.o -lc -I /lib/ld-linux-x86-64.so.2

clean:
		rm *.o add_asm
