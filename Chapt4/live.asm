; alive v 2

section .data
    msg     db  "Hello",0
    msg2    db  "Hell nah",0
    radius  dd  357
    pi      dq  3.14
    fmstr   db  "%s",10,0
    fmflt   db  "%lf",10,0
    fmint  db  "%d",10,0
section .bss
section .text
    extern  printf
    global  main
main:
    push    rbp
    mov     rbp, rsp

    mov     rax, 0
    mov     rdi, fmstr
    mov     rsi, msg
    call    printf

    mov     rax, 0
    mov     rdi, fmint
    mov     rsi, [radius]
    call    printf

    mov     rax, 1
    movq    xmm0, [pi]
    mov     rdi, fmflt
    call    printf

    mov     rsp, rbp
    pop     rbp

    ret