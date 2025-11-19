extern print_ret
section .data
    msg_s db " success ", 10
    msg_s_len equ $ - msg_s
    msg_f db " failure ", 10
    msg_f_len equ $ - msg_f

section .text
    global _start

_start :
    mov rax , -15
    cmp rax , 0
    jl .failure
    ; success
    mov rax , 1
    mov rdi , 1
    mov rsi , msg_s
    mov rdx , msg_s_len
    syscall
    jmp .end

.failure :
    mov rax , 1
    mov rdi , 1
    mov rsi , msg_f
    mov rdx , msg_f_len
    syscall

.end :
    mov rax , 60
    xor edi , edi
    syscall