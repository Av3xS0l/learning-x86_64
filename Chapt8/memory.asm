; memory.asm

section .data
    bnum    db  123
    wnum    dw  12345
    warray  times 5 dw  0

    dnum    dd  12345
    qnum1   dq  12345
    text1   db  "abc",0
    qNum2   dq  3.141592654
    text2   db  "cde",0
section .bss
    bvar    resb    1
    dvar    resd    1
    wvar    resw    10
    qvar    resq    3

section .text
	global main

main:
	push 	rbp
	mov 	rbp, rsp
	lea		rax, [bnum]
	mov		rax, bnum

	mov		rsp, rbp
	pop		rbp
	ret


