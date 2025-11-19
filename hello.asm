section .data
	message db "Hello World using NASM!", 10
	msg_len equ $ - message

section .text
	global _start

_start:
	mov rax , 1 		; syscall: write
	mov rdi , 1 		; file descriptor: stdout
	mov rsi , message 	; pointer to message
	mov rdx , msg_len 	; message length
	syscall

	mov rax , 60 		; syscall: exit
	xor rdi , rdi 		; status: 0
	syscall
