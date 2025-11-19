; for i in range(5)
	; print(i)

extern print_ret
section .data
	count db 5 ; Number of iterations
	i db 0     ; counter variable

section .text
	global _start

_start:
	mov ecx, [count] ; Loop counter stored in a register
	mov al, [i]

loop_start:    ; for a for-loop, start counting right away
	call print_ret
	inc al ; increments a register
	; call print_ret
	loop loop_start ; Loop until ECX == 0

	; Exit program
	mov eax, 60
	xor ecx, ecx
	syscall
