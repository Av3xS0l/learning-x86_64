#makefile for live.asm
live: live.o
	gcc -o live live.o -no-pie
live.o: live.asm
	nasm -f elf64 -g -F dwarf live.asm -l live.lst