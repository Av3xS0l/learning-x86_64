section .data
    one     db  "1", 0
    zero    db  "0", 0
    empt    db  " ", 0
    ext     db  10, 0

section .text
global printb
printb:
    push    rbp
    mov     rbp, rsp
    mov     rcx, 63          ; Initialize loop counter

prntloop:
    mov     rsi, rdi
    shr     rsi, cl          ; Shift rsi right by cl bits
    and     rsi, 1           ; Isolate the least significant bit
    push    rcx              ; Save rcx

    ; Check if we need to print a space
    cmp     cl, 55
    je      printempt
    cmp     cl, 47
    je      printempt
    cmp     cl, 39
    je      printempt
    cmp     cl, 31
    je      printempt
    cmp     cl, 23
    je      printempt
    cmp     cl, 15
    je      printempt
    cmp     cl, 7
    je      printempt
    jmp     skipempt

printempt:
    ; Print " "
    push    rdi
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, empt
    mov     rdx, 1
    syscall
    pop     rdi

skipempt:
    ; Print 1 or 0 based on the value of the bit
    test    rsi, 1
    jz      prntnull

    ; Print 1
    push    rdi
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, one
    mov     rdx, 1
    syscall
    pop     rdi
    jmp     continue

prntnull:
    ; Print 0
    push    rdi
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, zero
    mov     rdx, 1
    syscall
    pop     rdi
            
continue:
    pop     rcx              ; Restore rcx
    dec     rcx               ; Decrement cl
    cmp     rcx, 0
    jge     prntloop

    ; Print newline
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, ext
    mov     rdx, 1
    syscall

    leave
    ret