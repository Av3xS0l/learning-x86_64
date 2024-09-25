main: main.o printb.o
	gcc -g -o main main.o printb.o -no-pie
main.o: main.asm
	nasm -f elf64 -g -F dwarf main.asm -l main.lst
printb.o: printb.asm
	nasm -f elf64 -g -F dwarf printb.asm -l printb.lst