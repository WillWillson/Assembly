section .text
global print_ret

print_ret:
    push rbp
    mov rbp, rsp
    sub rsp, 32                ; reserve space for buffer

    push rax                   ; <-- preserve EAX (also affects RAX in 64-bit)
    push rbx                   ; we'll use RBX for printing logic
    push rcx
    push rdx
    push rsi
    push rdi
    push r8

    mov rcx, rsp
    add rcx, 55                ; move to the end of buffer (32 + 7 regs pushed = 56 bytes)
    mov byte [rcx], 10         ; newline '\n'
    dec rcx

    mov edi, 10                ; base 10 divisor

    ; Copy EAX into EBX for printing (preserve EAX)
    mov ebx, eax
    mov r8b, 0                 ; sign flag: 0 = positive

    test ebx, ebx
    jns .check_zero
    neg ebx
    mov r8b, 1                 ; mark as negative

.check_zero:
    cmp ebx, 0
    jne .convert_loop

    ; Special case for 0
    mov byte [rcx], '0'
    dec rcx
    jmp .maybe_sign

.convert_loop:
    xor edx, edx
    mov eax, ebx              ; move value to EAX for division
    div edi                   ; divide EAX by 10, result in EAX, remainder in EDX
    mov ebx, eax              ; update EBX with quotient
    add dl, '0'
    mov [rcx], dl
    dec rcx
    test ebx, ebx
    jnz .convert_loop

.maybe_sign:
    cmp r8b, 1
    jne .print_it
    mov byte [rcx], '-'
    dec rcx

.print_it:
    inc rcx                    ; point to first char
    mov rax, 1                 ; syscall: write
    mov rdi, 1                 ; fd: stdout
    mov rsi, rcx               ; buffer
    mov rdx, rsp
    add rdx, 56
    sub rdx, rcx               ; len = end - start
    syscall

    ; Restore clobbered registers
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax                    ; restore original EAX

    mov rsp, rbp
    pop rbp
    ret