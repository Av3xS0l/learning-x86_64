; stack.asm

extern printf

section .data
    string  db  "ABCDE",0
    strlen  equ $-string-1
    fmt1    db  "String 1: %s",10,0
    fmt2    db  "String 2: %s",10,0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    ; orgin
    mov     rdi, fmt1
    mov     rsi, string
    mov     rax, 0
    call    printf

    ; push to stack
        xor rax, rax
        mov rbx, string
        mov rcx, 0
        pushloop:
            mov     al, byte[rbx+rcx]
            push    rax
            inc     rcx
            cmp     rcx, strlen
            jl pushloop
        
        mov rbx, string
        mov rcx, 0
        
        poploop:
            pop     rax
            mov     byte [rbx+rcx], al
            inc     rcx
            cmp     rcx, strlen
            jl      poploop
        mov byte [rbx+rcx], 0

        ; output result
        mov     rdi, fmt2
        mov     rsi, string
        mov     rax, 0
        call    printf
        



    ; exit
    mov     rsp, rbp
    pop     rbp
    ret