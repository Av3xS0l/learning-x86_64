section .data
    msg1    db  "Hello world!",10,0
    len1    equ $-msg1
    msg2    db  "Your turn: ",0
    len2    equ $-msg2
    msg3    db  "You answered: ",0
    len3    equ $-msg3
    inlen   equ 10                      ; size of input buffer
section .bss
    input   resb    inlen+1             ; +1 for the terminating zero
section .text
    global  main:
main:
    push    rbp
    mov     rbp, rsp

    mov     rsi, msg1
    mov     rdx, len1
    call    prints

    mov     rsi, msg2
    mov     rdx, len2
    call    prints

    mov     rsi, input
    mov     rdx, inlen
    call    reads
    
    mov     rsi, msg3
    mov     rdx, len3
    call    prints

    mov     rsi, input
    mov     rdx, inlen
    call    prints


    leave
    ret


prints:
    push    rbp
    mov     rbp, rsp

    ; rsi contains adress of string
    ; rdx contains the len

        mov     rax, 1
        mov     rdi, 1
        syscall

    leave
    ret

reads:
    push    rbp
    mov     rbp, rsp

    ; rsi contains adress of input buffer
    ; rdi contains len of input buffer
        mov     rax, 0 ; read
        mov     rdi, 1
        syscall

    leave
    ret