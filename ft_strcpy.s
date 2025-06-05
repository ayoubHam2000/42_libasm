section .note.GNU-stack noalloc noexec nowrite

section .text
	global ft_strcpy

ft_strcpy:
	cld; forward direction
	mov r10, rdi; return
	_loop:
	lodsb ; AL = rsi++
	stosb ; rdi++ = AL
	test al, al; al & al
	jne _loop
	mov rax, r10
	ret


