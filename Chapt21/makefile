cli: cli.o
	gcc -o cli cli.o -no-pie
cli.o: cli.asm
	nasm -f elf64 -g -F dwarf cli.asm -l cli.lst