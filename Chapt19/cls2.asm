; cls2

section .data
    msg1    db  "Hello :)",10,0
    msg2    db  "Your turn (only a-z): ",0
    msg3    db  "You ansvered: ",0
    inlen   equ 10      ;buf len
    NL      db  0xa
section .bss
    input   resb    inlen+1
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, msg1
    call    prints
    mov     rdi, msg2
    call    prints

    mov     rdi, input
    mov     rsi, inlen
    call    reads

    mov     rdi, msg3
    call    prints
    mov     rdi, input
    call    prints

    mov     rdi, NL
    call    prints

    leave
    ret
; -------------------------------------------------

prints:
    push    rbp 
    mov     rbp, rsp

    push    r12         ; calee saved
    
    ; get msg len
    xor     rdx, rdx
    mov     r12, rdi

    .lenloop:
        cmp     byte [r12], 0
        je      .lenfound
        inc     rdx
        inc     r12
        jmp     .lenloop
    
    .lenfound:
        cmp     rdx, 0
        je      .done
        mov     rsi, rdi
        mov     rax, 1
        mov     rdi, 1
        syscall     
    
    .done:
    pop     r12
    leave
    ret
; --------------------------------------------------

reads:
section .bss
    .inchar     resb    1
section .text
    push    rbp
    mov     rbp, rsp
        push    r12         ; callee saved 12, 13, 14
        push    r13
        push    r14

        mov     r12, rdi
        mov     r13, rsi
        xor     r14, r14

    .readc:

        xor     rax, rax
        mov     rdi, 1
        lea     rsi, [.inchar]  ; address of input
        mov     rdx, 1          ; # chars to read
        syscall
        
        xor     rax, rax
        mov     al, [.inchar]   ;char is NL
        cmp     al, byte [NL]
        je      .done           ; NL = end
        cmp     al, 97          ; lower than a?
        jl      .readc          ; ignore
        cmp     al, 122         ; higher than z
        jg      .readc          ; ignore
        inc     r14             ; inc counter
        cmp     r14, r13
        ja      .readc          ; bufer max reached, ignore
        mov     byte [r12], al  ; save the char  in buffer
        inc     r12
        jmp     .readc

    .done:
    inc     r12
    mov     byte [r12],0
    pop     r14
    pop     r13
    pop     r12
    leave
    ret