extern printb
extern printf

section .data
    msgn1   db  "Number 1",10,0
    msgn2   db  "Number 2",10,0
    msg1    db  "XOR",10,0
    msg2    db  "OR",10,0
    msg3    db  "AND",10,0
    msg4    db  "NOT number 1",10,0
    msg5    db  "SHL",10,0
    msg6    db  "SHR",10,0
    msg7    db  "SAL",10,0
    msg8    db  "SAR",10,0
    msg9    db  "ROL 1",10,0
    msg10   db  "ROL 2",10,0
    msg11   db  "ROR 1",10,0
    msg12   db  "ROR 2",10,0
    num1    dq  -72
    num2    dq  1064
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    ; num 1 print custom
    mov     rsi, msgn1
    call    printmsg
    mov     rdi, [num1]
    call    printb

    ; num 2 print custom
    mov     rsi, msgn2
    call    printmsg
    mov     rdi, [num2]
    call    printb

    ; xor
    mov     rsi, msg1
    call    printmsg

    mov     rax, [num1]
    xor     rax, [num2]
    mov     rdi, rax
    call    printb

    ; or
    mov     rsi, msg2
    call    printmsg

    mov     rax, [num1]
    or      rax, [num2]
    mov     rdi, rax
    call    printb

    ; and
    mov     rsi, msg3
    call    printmsg

    mov     rax, [num1]
    and     rax, [num2]
    mov     rdi, rax
    call    printb

    ; not
    mov     rsi, msg4
    call    printmsg

    mov     rax, [num1]
    not     rax
    mov     rdi, rax
    call    printb

    ; shl
    mov     rsi, msg5
    call    printmsg

    mov     rax, [num1]
    shl     al, 2
    mov     rdi, rax
    call    printb

    ; shr
    mov     rsi, msg6
    call    printmsg

    mov     rax, [num1]
    shr     al, 2
    mov     rdi, rax
    call    printb

    ; sal
    mov     rsi, msg7
    call    printmsg

    mov     rax, [num1]
    sal     al, 2
    mov     rdi, rax
    call    printb

    ; sar
    mov     rsi, msg8
    call    printmsg

    mov     rax, [num1]
    sar     al, 2
    mov     rdi, rax
    call    printb

    ; rol 1
    mov     rsi, msg9
    call    printmsg

    mov     rax, [num1]
    rol     al, 2
    mov     rdi, rax
    call    printb
    mov     rsi, msg10
    call    printmsg
    mov     rax, [num2]
    rol     al, 2
    mov     rdi, rax
    call    printb

    ; ror 1
    mov     rsi, msg11
    call    printmsg

    mov     rax, [num1]
    ror     al, 2
    mov     rdi, rax
    call    printb
    mov     rsi, msg12
    call    printmsg
    mov     rax, [num2]
    ror     al, 2
    mov     rdi, rax
    call    printb
    
    leave
    ret
; ------------------------------------------------
printmsg:
section .data
    .fmtstr db  "%s",0
section .text
    mov     rdi, .fmtstr
    mov     rax, 0
    call    printf
    ret

