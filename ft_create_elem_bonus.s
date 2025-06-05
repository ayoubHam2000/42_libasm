section .note.GNU-stack noalloc noexec nowrite
default  rel   ; all symbol references become RIP-relative

section .text
	global ft_create_elem
	extern malloc


;t_list	*ft_create_elem(void *data);
ft_create_elem:
	push rdi

	; allocate to t_list struct
	mov rdi, 16; size of t_list struct
	call malloc wrt ..plt

	; check if malloc failed
	test rax, rax
	je ft_create_elem_error

	; load rdi from the stack
	pop rdi
	mov [rax], rdi; ->data = data
	mov qword [rax + 8], 0; ->next = NULL
	jmp ft_create_elem_end

	; if malloc failed remove rdi from the stack
	ft_create_elem_error:
	pop rdi
	ft_create_elem_end:
	ret




 



