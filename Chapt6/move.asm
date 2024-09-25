; move asm

section .data
    bNum    db  123
    wNum    dw  12345
    dNum    dd  1234567890
    qNum1   dq  123467890123456789
    qNum2   dq  123456
    qNum3   dq  3.14
section .bss
section .text
    global  main

main:
    push rbp
    mov rbp, rsp

    mov rax, -1         ; fill rax with 1s
    mov al, byte [bNum] ; does not interact with upper bits
    xor rax, rax        ; clear rax
    mov al, byte [bNum] ; moves the right val to rax

    mov rax, -1         ; fill rax with 1s
    mov ax, word [wNum] ; does not interact with upper bits
    xor rax, rax        ; clear rax
    mov ax, word [wNum] ; moves the right val to rax

    mov rax, -1
    mov eax, dword [dNum] ; DOES clear the upper bits

    mov rax, -1
    mov rax, qword [qNum1]
    mov qword [qNum2], rax
    mov rax, 123456
    
    movq xmm0, [qNum3] ; for floats
    
    mov rsp, rbp
    pop rbp

    ret
