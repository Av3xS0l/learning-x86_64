; sreverse.asm
section .data
section .bss
section .text
    global sreverse
sreverse:
    push    rbp
    mov     rbp, rsp
    pushing:
        mov     rcx, rsi
        mov     rbx, rdi
        xor     r12, r12
        pushloop:       
            mov     rax, qword [rbx+r12]
            push rax
            inc     r12
            cmp     r12, rcx
            jl      pushloop
    popping:
        mov     rcx, rsi
        mov     rbx, rdi
        xor     r12, r12
        poploop:
            pop     rax
            mov     byte [rbx+r12], al
            inc     r12
            cmp     r12, rcx            
            jl    poploop
    mov     rax, rdi
    leave
    ret