; bits3.asm
extern  printb
extern  printf

section .data
    msg1    db  "No bits set: ",10,0
    msg2    db  10,"Set #4: ",10,0
    msg3    db  10,"Set #7: ",10,0
    msg4    db  10,"Set #9: ",10,0
    msg5    db  10,"Set #61: ",10,0
    msg6    db  10,"Clear #8: ",10,0
    msg7    db  10,"Test #61, show rdi: ",10,0
    bitflags    dq  0
section .bss
section .text
    global  main
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, msg1
    xor     rax, rax
    call    printf

    mov     rdi, [bitflags]
    call    printb

    ;set bit 4
    mov     rdi, msg2
    xor     rax, rax
    call    printf

    bts     qword [bitflags], 4 ; set 4th bit of bitflags
    mov     rdi, [bitflags]
    call    printb

    ; set bit 7
    mov     rdi, msg3
    xor     rax, rax
    call    printf

    bts     qword [bitflags], 7
    mov     rdi, [bitflags]
    call    printb

    ; set bit 8
    mov     rdi, msg4
    xor     rax, rax
    call    printf

    bts     qword [bitflags], 8
    mov     rdi, [bitflags]
    call    printb

    ; set bit 61
    mov     rdi, msg5
    xor     rax, rax
    call    printf

    bts     qword [bitflags], 61
    mov     rdi, [bitflags]
    call    printb

    ; clear bit 8
    mov     rdi, msg6
    xor     rax, rax
    call    printf

    btr     qword [bitflags], 8
    mov     rdi, [bitflags]
    call    printb

    ; test bit 61
    mov     rdi, msg7
    xor     rax, rax
    call    printf

    xor     rdi, rdi        ; clear rdi
    mov     rax, 61         ; # bit to be tested -> rax
    bt      [bitflags], rax ; bit test
    setc    dil             ; set dil (low rdi) to 1 if CF is set
    call    printb
            


    leave
    ret
