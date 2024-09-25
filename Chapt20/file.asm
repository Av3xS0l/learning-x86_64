; file.asm

section .data
    ; conditional ASM expressions
    CREATE      equ 1
    OVERWRITE   equ 0
    APPEND      equ 0
    O_WRITE     equ 0
    READ        equ 0
    O_READ      equ 0
    DELETE      equ 0

    ; syscall symbols
    NR_read     equ 0
    NR_write    equ 1
    NR_open     equ 2
    NR_close    equ 3
    NR_lseek    equ 8
    NR_create   equ 85
    NR_unlink   equ 87

    ; creation and status flags
    O_CREAT     equ 00000100q
    O_APPEND    equ 000020000q

    ; access mode
    O_RDONLY    equ 000000q
    O_WRONLY    equ 000001q
    O_RDWR      equ 000002q

    ; create mode (permissions)
    S_IRUSER    equ 00400q  ; user read
    S_IWUSER    equ 00200q  ; user write

    NL          equ 0xa
    bufferlen   equ 64
    filename    db  "testfile.txt",0
    FD          dq  0       ; file descriptor (?)

    text1       db  "1. Hello... To everyone!",NL,0
    len1        dq  $-text1-1
    text2       db  "2. Here I am!",NL,0
    len2        dq  $-text2-1
    text3       db  "3. Alive and kicking!",NL,0
    len3        dq  $-text3-1
    text4       db  "Adios !!!",NL,0
    len4        dq  $-text4-1

    err_Create  db  "Error creating file",NL,0
    err_Close   db  "Error closing file",NL,0
    err_Write   db  "Error writing to file",NL,0
    err_Open    db  "Error opening file"
    err_Append  db  "Error appending to file",NL,0
    err_Delete  db  "Error deleting file",NL,0
    err_Read    db  "Error reading from file",NL,0
    err_Print   db  "Error printing string",NL,0
    err_Pos     db  "Error positioned in file",NL,0

    suc_Create  db  "File created and opened",NL,0
    suc_Close   db  "File closed",NL,0
    suc_Write   db  "Written to file",NL,0
    suc_Open    db  "File opened",NL,0
    suc_Append  db  "File opened and appending",NL,0
    suc_Delete  db  "File deleted",NL,0
    suc_Read    db  "Reading file",NL,0
    suc_Pos     db  "Positioned in file",NL,0

section .bss
    buffer      resb    bufferlen
section .text
    global      main
main:
    push    rbp
    mov     rbp, rsp

    %IF CREATE
        ; create > open > close
        mov     rdi, filename
        call    createFile
        mov     qword [FD], rax ; save descriptor

        ; write to file #1
        mov     rdi, qword [FD]
        mov     rsi, text1
        mov     rdx, qword [len1]
        call    writeFile

        ; close file
        mov     rdi, qword [FD]
        call    closeFile
    %ENDIF
    %IF OVERWRITE
        ; open > overwrite - close

        mov     rdi, filename
        call    openFile
        mov     qword [FD], rax

    ; write to file - OVERWRITE
        mov     rdi, qword [FD]
        mov     rsi, text2
        mov     rdx, qword [len2]
        call    writeFile
    
    ; close file
        mov     rdi, qword [FD]
        call    closeFile
    %ENDIF
    %IF APPEND
        ; open > append > close
        mov     rdi, filename
        call    appendFile
        mov     qword [FD], rax
    
    ; append to file
        mov     rdi, qword [FD]
        mov     rsi, text3
        mov     rdx, qword [len3]
        call    writeFile
    
    ; close
        mov     rdi, qword [FD]
        call    closeFile
    %ENDIF
    %IF O_WRITE
        ; open > overwrite at offset > close
        mov     rdi, filename
        call    openFile
        mov     qword [FD], rax
    
    ; pos at offset
        mov     rdi, qword[FD]
        mov     rsi, qword[len2]
        mov     rdx, 0
        call    positionFile

    ; write at offset
        mov     rdi, qword[FD]
        mov     rsi, text4
        mov     rdx, qword[FD]
        call    writeFile
    
    ; close
        mov     rdi, qword[FD]
        call    closeFile
    %ENDIF
    %IF READ
        ; open > read > close

        mov     rdi, filename
        call    openFile
        mov     qword[FD], rax

    ; read
        mov     rdi, qword[FD]
        mov     rsi, buffer
        mov     rdx, bufferlen
        call    readFile
        mov     rdi, rax
        call    printString

    ; close
        mov     rdi, qword[FD]
        call    closeFile
    
    %ENDIF
    %IF O_READ
    ; open > read > offset
        mov     rdi, filename
        call    openFile
        mov     qword[FD], rax

    ; position at offset
        mov     rdi, qword[FD]
        mov     rsi, qword[len2]
        mov     rdx, 0
        call    positionFile
    
    ; read
        mov     rdi, qword[FD]
        mov     rsi, buffer
        mov     rdx, 10
        call    readFile
        mov     rdi, rax
        call    printString

    ; close
        mov     rdi, qword [FD]
        call    closeFile
    %ENDIF
    %IF DELETE
    ; delete
        mov     rdi, filename
        call    deleteFile
    %ENDIF

    leave
    ret

; FILE MANIPULATION FUNCTIONS -----------

global readFile
readFile:
    mov     rax, NR_read
    syscall
    cmp     rax, 0
    jl      readerror
    mov     byte [rsi+rax], 0
    mov     rax, rsi

    mov     rdi, suc_Read
    push    rax
    call    printString
    pop     rax
    ret
readerror:
    mov     rdi, err_Read
    call    printString
    ret

; -----------
global deleteFile
deleteFile:
    mov     rax, NR_unlink
    syscall
    cmp     rax, 0
    jl      deleteerror
    mov     rdi, suc_Delete
    call    printString
    ret
deleteerror:
    mov     rdi, err_Delete
    call    printString
    ret

; --------------
global appendFile
appendFile:
    mov     rax, NR_open
    mov     rsi, O_RDWR|O_APPEND
    syscall
    cmp     rax, 0
    jl      appenderror
    mov     rdi, suc_Append
    push    rax
    call    printString
    pop     rax
    ret
appenderror:
    mov     rdi, err_Append
    call    printString
    ret
; ----------------
global openFile
openFile:
    mov     rax, NR_open
    mov     rsi, O_RDWR
    syscall
    cmp     rax, 0
    jl      openerror
    mov     rdi, suc_Open
    push    rax
    call    printString
    pop rax
    ret
openerror:
    mov     rdi, err_Open
    call    printString
    ret
; -----------------
global  writeFile
writeFile:
    mov     rax, NR_write
    syscall
    cmp     rax, 0
    jl      writeerror
    mov     rdi, suc_Write
    call    printString
    ret
writeerror:
    mov     rdi, err_Write
    call    printString
    ret
; ------------------
global positionFile
positionFile:
    mov     rax, NR_lseek
    syscall
    cmp     rax, 0
    jl      positionerror
    mov     rdi, suc_Pos
    call    printString
    ret
positionerror:
    mov     rdi, err_Pos
    call    printString
    ret
; -------------------
global closeFile
closeFile:
    mov     rax, NR_close
    syscall
    cmp     rax, 0
    jl      closeerror
    mov     rdi, suc_Close
    call    printString
    ret
closeerror:
    mov     rdi, err_Close
    call    printString
    ret
; --------------------
global createFile
createFile:
    mov     rax, NR_create
    mov     rsi, S_IRUSER|S_IWUSER
    syscall
    cmp     rax, 0
    jl      createerror
    mov     rdi, suc_Create
    push    rax
    call    printString
    pop     rax
    ret
createerror:
    mov     rdi, err_Create
    call    printString
    ret
; PRINT FEEDBACK
; -------------------
global printString
printString:
    mov     r12, rdi
    mov     rdx, 0
    strLoop:
        cmp     byte [r12], 0
        je      strDone         ; len in rdx
        inc     rdx
        inc     r12
        jmp     strLoop
    strDone:            ; no string -> len 0
        cmp     rdx, 0
        je      prtDone
        mov     rsi, rdi
        mov     rax, 1
        mov     rdi, 1
        syscall
    prtDone:
        ret

