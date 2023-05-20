all: arr_asm

program.o:  program.asm
		nasm -f elf64 program.asm

gen_rand.o:  gen_rand.c
		gcc gen_rand.c -c

arr_asm: program.o gen_rand.o
		ld -o arr_asm gen_rand.o program.o -lc -I /lib/ld-linux-x86-64.so.2

clean:
		rm *.o add_asm
