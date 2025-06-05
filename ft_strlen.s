section .note.GNU-stack noalloc noexec nowrite

section .text
	global ft_strlen

ft_strlen:
	xor rax, rax
	compare_and_increment:
	cmp byte [rdi + rax], 0x0
	je compare_end
	inc rax
	jmp compare_and_increment
	compare_end:
	ret


