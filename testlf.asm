section .text
	global _start
	global testlf
	
_start:

	; Setting arguments, and calling the function
	mov rdi, 5		; x = 5
	mov rsi, 3		; y = 3
	call testlf		; function call
	
	; Exit the program
	mov rax, 60
	xor rdi, rdi
	syscall
	
; Function
testlf:
	mov rax, rdi		; rax = x
	add rax, rsi		; rax = x + y
	
	cmp rdi, 0		; comparing x
	jl .done		; jump and not do the subtraction
	
	mov rax, rdi		; rax = x
	sub rax, rsi		; rax = x - y
	
.done:
	ret
