cls1: cls2.o
	gcc -g -o cls2 cls2.o -no-pie
cls2.o: cls2.asm
	nasm -f elf64 -g -F dwarf cls2.asm -l cls2.lst