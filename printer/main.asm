extern printb
section .data
    skaitlis    dq  12
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp 
    

    mov     rdi, [skaitlis]
    call    printb

    leave
    ret

