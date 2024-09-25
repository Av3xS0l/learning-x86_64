; asum.asm
section .data
section .bss
section .text
    global asum
asum:
    section .text
; calculate sum
    push    rbp
    mov     rbp, rsp
    mov     rcx, rsi
    mov     rbx, rdi
    xor     r12, r12
    movsd   xmm0, qword [rbx+r12*8]
    dec     rcx     ; 1st element already in
    sloop:
        inc     r12
        addsd   xmm0, qword [rbx+r12*8]
        cmp     r12, rcx
        jl      sloop
    leave
    ret
