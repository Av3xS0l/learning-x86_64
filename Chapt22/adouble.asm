; adouble.asm
section .data
section .bss
section .text
    global  adouble
adouble:
    section .text
        push    rbp
        mov     rbp, rsp
        mov     rcx, rsi
        mov     rbx, rdi
        xor     r12, r12
        dloop:
            movsd   xmm0, qword [rbx+r12*8]
            addsd   xmm0, xmm0
            movsd   qword [rbx+r12*8], xmm0
            inc     r12
            cmp     r12, rcx
            jl      dloop
        leave
        ret