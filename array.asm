extern print_ret
section .data
	array dq 10, 20, 30, 40, 50  ; array of 64-bit integers
	index dq 2                   ; index

section .text
	global _start

_start:
	mov rbx, [index]             ; index
	mov rax, [array + rbx*8]     ; should store 30 in rax
	call print_ret

	inc rbx
	mov rax, [array + rbx*8]
	call print_ret

	; exit
	mov rax, 60
	xor edi, edi
	syscall
