extern print_ret
section .data
	; counter = 0
	counter db 0     ; counter starts at 0

section .text
	global _start

_start:
	mov eax, [counter]  ; store our counter
	xor r10d, r10d      ; zero's out register

while:
	cmp eax, 5
	; while counter <= 5: -> counter greater than
	jg .end_while
	call print_ret
	inc eax
	jmp while

.end_while:
	xor r10d, r10d
	mov rax, 60
	xor edi, edi
	syscall
