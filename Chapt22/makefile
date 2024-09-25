fromc: fromc.c rect.o circ.o sreverse.o asum.o adouble.o
	gcc	-o fromc fromc.c rect.o circ.o sreverse.o asum.o -no-pie
rect.o: rect.asm
	nasm -f elf64 -g -F dwarf rect.asm -l rect.lst
circ.o: circ.asm
	nasm -f elf64 -g -F dwarf circ.asm -l circ.lst
sreverse.o: sreverse.asm
	nasm -f elf64 -g -F dwarf sreverse.asm -l sreverse.lst
asum.o: asum.asm
	nasm -f elf64 -g -F dwarf asum.asm -l asum.lst
adouble.o: adouble.asm
	nasm -f elf64 -g -F dwarf adouble.asm -l adouble.lst
