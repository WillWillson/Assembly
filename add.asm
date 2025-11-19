section .text
	global _start
	global add_numbers 	; Declare function for external use

_start:
	mov edi , 3 		; First argument ( a )
	mov esi , 4 		; Second argument ( b )
	mov ebx , 5		; Third argument ( c )
	mov ecx , 6		; Fourth argument ( d )
	mov edx , 7		; Fifth argument ( e )
	call add_numbers 	; Call function
	; EAX now contains the result (3 + 4 + 5 + 6 + 7)

	; Exit program
	mov eax , 60 ; syscall : exit
	xor edi , edi
	syscall

add_numbers:
	mov eax , edi ; Load first argument
	add eax , esi ; Add second argument
	add eax , ebx ; Add third argument
	add eax , ecx ; Add fourth argument
	add eax , edx ; Add fifth argument
	ret
