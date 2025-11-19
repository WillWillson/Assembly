extern print_ret
section .data
    a dq 5
    b dq 6
    c dq -3

section .text
    global _start

_start :
    xor r15 , r15 ; sign flag
    ; load and check a
    mov r9 , [ a ]
    cmp r9 , 0
    jge .skipNegativeA
    inc r15
    neg r9 ; abs(a)

.skipNegativeA :
    mov r10 , [ b ]
    cmp r10 , 0
    jge .skipNegativeB
    inc r15
    neg r10 ; abs(b)

.skipNegativeB :
    mov r13 , 0
    xor rax , rax
    call mul
    ; store intermediate result into r12
    mov r12 , rax
    mov r13 , [ c ]
    cmp r13 , 0
    jge .skipNegativeC
    inc r15
    neg r13 ; abs(c)

.skipNegativeC :
    xor rax , rax
    call mul2
    ; check final sign should be negative (odd # of neg)
    test r15 , 1
    jz .noNeg
    neg rax

.noNeg :
    call print_ret
    ; exit
    mov rax , 60
    xor edi , edi
    syscall

mul: ; not real imul
    cmp r13 , r10
    jge .doneMul
    add rax , r9
    inc r13
    jmp mul

.doneMul :
    ret

mul2 :
    cmp r13 , 0
    je .doneMul2
    add rax , r12
    dec r13
    jmp mul2
.doneMul2
    ret