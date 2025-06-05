section .note.GNU-stack noalloc noexec nowrite

section .text
	global ft_list_push_front
	extern ft_create_elem

;void	ft_list_push_front(t_list **begin_list, void *data);
ft_list_push_front:
	push rdi

	; create new element
	mov rdi, rsi
	call ft_create_elem
	test rax, rax
	je ft_list_push_front_create_error


	pop rdi
	test rdi, rdi
	je create_new_list
	
	; if begin_list exist push element to front of the list
	; element->next = *begin_list
	mov r10, [rdi]
	mov [rax + 8], r10

	; create new list (begin_list = NULL)
	create_new_list:
	mov [rdi], rax
	jmp ft_list_push_font_end

	ft_list_push_front_create_error:
	pop rdi
	ft_list_push_font_end:
	ret