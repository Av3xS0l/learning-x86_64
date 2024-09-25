section .data
section .bss
section .text
global  r_area
r_area:
    section .text
    push    rbp
    mov     rbp, rsp
        mov     rax, rsi
        imul    rax, rdi
        mov     rsp, rbp
    pop     rbp
    ret

global r_circum
r_circum:
    section .text
    push    rbp
    mov     rbp, rsp
        mov     rax, rdi
        add     rax, rsi
        add     rax, rax
    mov     rsi, rbp
    pop     rbp
    ret