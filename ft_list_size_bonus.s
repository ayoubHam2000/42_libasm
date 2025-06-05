section .note.GNU-stack noalloc noexec nowrite

section .text
	global ft_list_size

; int	ft_list_size(t_list *begin_list);
ft_list_size:
	xor ecx, ecx
	ft_list_size_loop:
	test rdi, rdi
	je ft_list_size_end
	inc ecx
	mov rdi, [rdi + 8]
	jmp ft_list_size_loop

	ft_list_size_end:
	mov eax, ecx
	ret