;hello.asm
section .data
    msg     db "hello, world", 10

section .bss
section .text
    global main
main:
    mov     rax, 1      ; write
    mov     rdi, 1      ; to stdout
    mov     rsi, msg    ; string to display
    mov     rdx, 13      ; len without the 0
    syscall

    mov     rax, 60     ; exit
    mov     rdi, 0      ; exit code 0
    syscall