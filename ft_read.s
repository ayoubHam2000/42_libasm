section .note.GNU-stack noalloc noexec nowrite
default  rel   ; all symbol references become RIP-relative

section .text
	global ft_read
	extern __errno_location

ft_read:
	mov rax, 0
	syscall
	cmp rax, -4095
	jae ft_read_error
	jmp ft_read_end
	ft_read_error:
	neg eax
	push rbx
	mov rbx, rax
	call __errno_location  wrt ..plt
	mov [rax], ebx
	mov rax, -1
	pop rbx
	ft_read_end:
	ret