; icalc.asm

extern  printf
section .data
    number1 dq  128                                 ; the used number
    number2 dq  19
    neg_num dq  -12
    fmt     db  "The numbers are %ld and %ld",10,0
    fmtint  db  "%s %ld",10,0
    sumi    db  "The sum is",0
    difi    db  "The difference is",0
    inci    db  "Number 1 incremented:",0
    deci    db  "Number 1 decremented:",0
    sali    db  "Number 1 Shift left 2 (x4):",0
    sari    db  "Number 1 Shift right 2 (/4):",0
    sariex  db  "Number 1 Shift right 2 (/4) with "
            db  "sign extention:",0
    multi   db  "The product is:",0
    divi    db  "The integer quoitent is:",0
    remi    db  "The modulo is:",0

section .bss
    resulti resq    1
    modulo  resq    1

section .text
    global main

main:
        
    push    rbp
    mov     rbp, rsp

    ; display the numbers
    mov     rdi, fmt
    mov     rsi, [number1]
    mov     rdx, [number2]
    xor       rax, rax
    call    printf
    
    ; adding
    mov     rax, [number1]
    add     rax, [number2]
    mov     [resulti], rax

        mov     rdi, fmtint
        mov     rsi, sumi
        mov     rdx, [resulti]
        xor       rax, rax
        call    printf
    ; subtracting
    mov     rax, [number1]
    sub     rax, [number2]
    mov     [resulti], rax

        mov     rdi, fmtint
        mov     rsi, difi
        mov     rdx, [resulti]
        xor       rax, rax
        call    printf
    
    ; increments
    mov     rax, [number1]
    inc     rax
    mov     [resulti], rax

        mov     rdi, fmtint
        mov     rsi, inci
        mov     rdx, [resulti]
        xor       rax, rax
        call    printf
    
    ; decrement
    mov     rax, [number1]
    dec     rax
    mov     [resulti], rax

        mov     rdi, fmtint
        mov     rsi, deci
        mov     rdx, [resulti]
        xor       rax, rax
        call    printf
    
    ; aritmetic shift left = *2
    mov     rax, [number1]
    sal     rax, 2
    mov     [resulti], rax

        mov     rdi, fmtint
        mov     rsi, sali
        mov     rdx, [resulti]
        xor       rax, rax
        call    printf

    ; araithmetic shift right = /2
    mov     rax, [number1]
    sar     rax, 2
    mov     [resulti], rax

        mov     rdi, fmtint
        mov     rsi, sari
        mov     rdx, [resulti]
        xor       rax, rax
        call    printf
    
    ; Ashr with sign extention
    mov     rax, [number1]
    sar     rax, 2
    mov     [resulti], rax

        mov     rdi, fmtint
        mov     rsi, sari
        mov     rdx, [resulti]
        xor     rax, rax
        call    printf

    ; multiply
    mov     rax, [number1]
    imul    qword [number2]
    mov     [resulti], rax

        mov     rdi, fmtint
        mov     rsi, multi
        mov     rdx, [resulti]
        xor     rax, rax
        call    printf

    ; divide
    mov     rax, [number1]
    xor     rdx, rdx
    idiv    qword [number2]
    mov     [resulti], rax
    mov     [modulo], rdx

        mov     rdi, fmtint
        mov     rsi, divi
        mov     rdx, [resulti]
        xor     rax, rax
        call    printf

        mov     rdi, fmtint
        mov     rsi, remi
        mov     rdx, [modulo]
        xor     rax, rax
        call    printf

    mov     rsp, rbp
    pop     rbp
    ret
