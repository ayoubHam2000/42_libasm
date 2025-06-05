section .note.GNU-stack noalloc noexec nowrite

section .text
	global ft_strcmp

ft_strcmp:
	push rbx
	; rdi = s1, rsi = s2
	; return rax
	xor rcx, rcx ; counter
	jmp _loop_strcmp ; start comparing
	_cool: ; if s1 == s2
	cmp al, 0
	je _end ; if s1 == s2 and *s1 == 0
	_loop_strcmp:
	mov al, byte [rdi + rcx]
	mov bl, byte [rsi + rcx]
	inc rcx
	cmp al, bl
	je _cool
	_end:
	and rax, 0xff
	and rbx, 0xff
	sub rax, rbx
	pop rbx
	ret