extern printf
extern c_area
extern c_circum
extern r_area
extern r_circum
global pi

section .data
    pi      dq  3.141592654
    radius  dq  10.0
    side1   dq  4
    side2   dq  5
    fmtf    db  "%s %f",10,0
    fmti    db  "%s %d",10,0
    ca      db  "Circle area: ",0
    cc      db  "Circle circum: ",0
    ra      db  "Rect area: ",0
    rc      db  "Rect circum: ",0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    ; circle
    movsd   xmm0, qword [radius]
    call c_area
    ; print area
        mov     rdi, fmtf
        mov     rsi, ca
        mov     rax, 1
        call printf
    
    movsd   xmm0, qword [radius]
    call    c_circum

        mov     rdi, fmtf
        mov     rsi, cc
        mov     rax, 1
        call printf
    
    ; rectang
    mov     rdi, [side1]
    mov     rsi, [side2]
    call    r_area

        mov     rdi, fmti
        mov     rsi, ra
        mov     rdx, rax
        mov     rax, 0
        call    printf
    
    mov     rdi, [side1]
    mov     rsi, [side2]
    call    r_circum

        mov     rdi, fmti
        mov     rsi, rc
        mov     rdx, rax
        mov     rax, 0
        call    printf
    mov     rsp, rbp
    pop     rbp
    ret
    