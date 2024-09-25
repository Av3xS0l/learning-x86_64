; rdi ir skaitlis, kas man jāizvada


section .data
section .bss
section .text
    global printb
printb:
section .data
    .one     db  "1",0
    .zero    db  "0",0
    .empt    db  " ",0
section .bss
section .text
    push    rbp
    mov     rbp, rsp
    mov     r8, 63
    prntloop:

        mov     rsi, rdi
        shr     rsi, r8

        cmp     r8,55
        je      printempt
        cmp     r8,47
        je      printempt
        cmp     r8,39
        je      printempt
        cmp     r8,31
        je      printempt
        cmp     r8,23
        je      printempt
        cmp     r8,15
        je      printempt
        cmp     r8,7
        je      printempt
        jmp skipempt
        printempt:
            ; print " "
            push    rdi
            mov     rax, 1
            mov     rdi, 1
            mov     rsi, .empt
            mov     rdx, 1
            syscall
            pop     rdi

        skipempt:
        ; if s & 1
        cmp     rsi, 1
        jne     prntnull
        ; print 1
        push    rdi
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, .one
        mov     rdx, 1
        syscall
        pop     rdi
        jmp continue

        prntnull:
        ; print 0
        push    rdi
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, .zero
        mov     rdx, 1
        syscall
        pop     rdi
        continue:
        
        dec     r8
        cmp     r8, 0
        jge     prntloop
    
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, 10
    mov     rdx, 1
    syscall
    leave
    ret