section .note.GNU-stack noalloc noexec nowrite

section .text
	global ft_list_sort
    
; void	ft_list_sort(t_list **begin_list, int (*cmp)(void *, void *));
ft_list_sort:
	; must be saved and restored
	push rbx
	push r12
	push r13
	mov rbx, rsi

	; ptr1 = *begin_list
	mov r12, [rdi]
	
	loop:
	; if ptr1 == NULL goto end
	test r12, r12
	je end

	; ptr2 = ptr1->next
	mov r13, [r12 + 8]

	; if ptr2 == NULL goto next_loop
	inner_loop:
	test r13, r13
	je next_loop
	
	mov rdi, [r12]
	mov rsi, [r13]
	call rbx; call to cmp function
	
	; if cmp <= 0 goto next_inner_loop
	cmp eax, 0
	jle next_inner_loop

	; swap data if cmp > 0 then goto next_inner_loop
	mov r10, [r12]; r10 = ptr1->data
	mov r11, [r13]; r11 = ptr2->data
	mov [r12], r11; ptr1->data = r11 aka ptr2->data
	mov [r13], r10; ptr2->data = r10 aka ptr1->data
	
	next_inner_loop:
	mov r13, [r13 + 8]
	jmp inner_loop

	next_loop:
	mov r12, [r12 + 8]
	jmp loop

	end:
	pop r13
	pop r12
	pop rbx
	ret
