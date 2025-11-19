extern print_ret
section .data
	total db 5    ; number of iterations
	i db 0        ; increment

section .text
	global _start

_start:
	mov al, [i]
	mov cl, [total]

.loop_check:
	cmp al, cl
	jg .end_loop   ; i <= total -> i > total
	push rax
	push rcx
	call print_ret
	pop rcx
	pop rax
	inc al
	jmp .loop_check

.end_loop:
	xor rax, rax
	xor rcx, rcx
	mov rax, 60
	xor edi, edi
	syscall

