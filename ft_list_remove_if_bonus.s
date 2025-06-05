section .note.GNU-stack noalloc noexec nowrite
default rel


section .text
	global ft_list_remove_if
	extern free
    
; void		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void *, void *));
ft_list_remove_if:
	push r12
	push r13
	push r15
	push rbx

	mov r12, [rdi]; ptr = *begin_list
	mov r13, 0; prev
	mov r15, rdi; tmp form begin_list
	mov rbx, rdx

	loop:
	
	test r12, r12; test if ptr == NULL
	je end

	;cmp(ptr->data, data_ref)
	mov rdi, [r12]
	; rsi already set
	call rbx
	test rax, rax; test if cmp(...) == 0
	jne next_item
	
	test r13, r13; test if prev == NULL
	jne remove_with_prev

	; if prev == NULL
	mov r10, [r12 + 8]
	mov [r15], r10; *begin_list = ptr->next
	mov rdi, r12; to_remove = ptr 
	mov r12, r10; ptr = ptr->next
	call free wrt ..plt; free(to_remove)
	jmp loop

	; if prev != NULL
	remove_with_prev:
	mov r10, [r12 + 8]
	mov rdi, r12; to_remove = ptr 
	mov [r13 + 8], r10; prev->next = ptr->next
	mov r12, r10; ptr = ptr->next
	call free wrt ..plt; free(to_remove)
	jmp loop

	; if cmp() != 0
	next_item:
	mov r13, r12; prev = ptr
	mov r12, [r12 + 8]; ptr = ptr->next
	jmp loop

	; ptr == NULL
	end:
	pop rbx
	pop r15
	pop r13
	pop r12
	ret