; cli.asm
extern printf
section .data
    msg     db  "Arguments are: ",10,0
    fmt     db  "%s",10,0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     r12, rdi    ; number of arguments
    mov     r13, rsi    ; adress of argument array
    
    mov     rdi, msg
    call    printf

    xor     r14, r14

    .ploop:
        mov     rdi, fmt
        mov     rsi, qword [r13+r14*8]  ; loop bytes
        call    printf
        inc     r14
        cmp     r14, r12
        jl      .ploop

    leave
    ret