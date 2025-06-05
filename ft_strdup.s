section .note.GNU-stack noalloc noexec nowrite
default  rel   ; all symbol references become RIP-relative

section .text
	global ft_strdup
	extern malloc
	extern ft_strlen
	extern ft_strcpy

ft_strdup:
	push rdi

	; calculate the string length
	call ft_strlen
	inc rax

	;call to malloc
	mov rdi, rax
	call malloc wrt ..plt

	;test if malloc failed
	test rax, rax
	je ft_strdup_error; rax=NULL

	;copy the source string to the allocated memory
	mov rdi, rax; destination is the allocated memory
	pop rsi; load the source string from stack
	call ft_strcpy;
	jmp ft_strdup_end
	ft_strdup_error:
	pop rdi; remove rdi from the stack
	ft_strdup_end:
	ret