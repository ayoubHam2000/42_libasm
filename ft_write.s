section .note.GNU-stack noalloc noexec nowrite
default  rel   ; all symbol references become RIP-relative

section .text
	global ft_write
	extern __errno_location

ft_write:
	; rdi=fd, rsi=buf, rdx=nbyte
	mov rax, 1; write sys call
	syscall
	cmp rax, -4095; check if rax < 0 and rax > -4095 that because -4095 is large unsigned number
	; the kernel always return an error in the range [-1, -4095]
	jae ft_write_error ; Above or equal (unsigned)	unsigned
	jmp ft_write_end
	ft_write_error:
	neg eax; errno is 32bit number
	push rbx; sore the old value of rbx (standard)
	mov rbx, rax
	call __errno_location  wrt ..plt; get the pointer of errno
	; gcc enables PIE by default.
	; Use RIP-relative addressing so the relocation goes through the PLT / GOT and doesn’t modify .text.
	mov [rax], ebx
	mov rax, -1
	pop rbx
	ft_write_end:
	ret