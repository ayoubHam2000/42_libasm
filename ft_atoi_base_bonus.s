section .note.GNU-stack noalloc noexec nowrite
default rel

section .data
  SPACE_CHAR db 0x9, 0xb, 0xa, 0xd, 0xc, 0x20, 0x0; "\t\v\n\r\f "

section .text
	global ft_atoi_base

; size_t nb_char(char c, char *str)
; check if how man c in str
nb_char:
  xor rcx, rcx; counter = 0

  nb_char_loop:
  lodsb; al = *str; str++; modify rdi
  
  ; if *str == 0 return
  cmp al, 0
  je nb_char_end

  ; if *str ==c increment rcx else loop
  cmp al, dil; byte rdi
  jne nb_char_loop
  inc rcx

  ; loop
  jmp nb_char_loop

  nb_char_end:
  mov rax, rcx
  ret

;int check_base(char *base); check the base and return the length of the base
check_base:
  push r12

  mov r12, rdi

  check_base_loop:
  mov bl, byte [r12]
  cmp bl, 0
  je check_base_loop_end
  inc r12
  cmp bl, 45; '-'
  je check_base_error
  cmp bl, 43; '+'
  je check_base_error
  cmp bl, 33
  jl check_base_error
  cmp bl, 126
  jg check_base_error
  push rdi
  mov rsi, rdi; 1st arg = base
  mov dil, bl; 2sec arg = bl
  call nb_char
  pop rdi
  cmp al, 1; a character can't be duplicated
  jg check_base_error
  jmp check_base_loop

  check_base_loop_end:
  sub r12, rdi; calculate base length
  cmp r12, 2
  jl check_base_error
  
  ; check_base success
  mov rax, r12; return base length
  pop r12
  ret

  check_base_error:
  mov rax, -1
  pop r12
  ret

;char *ft_strchr(char c, char *str)
; check if c in str, assuming that c != 0
ft_strchr:
  xor rcx, rcx
  
  ft_strchr_loop:
  lodsb; al=sil; rsi++
  
  cmp al, 0
  je ft_strchr_end

  cmp al, dil
  jne ft_strchr_loop
  ; return rsi
  dec rsi
  mov rax, rsi
  ret

  ft_strchr_end:
  mov rax, 0
  ret

; char *check_number(char *str, char *base);
; check if str contain a valid number
; escape all starting blank
; escape sign 
; check if str character are all in base
; return a pointer to the start of the number
check_number:
  push r12
  push r13
  push r14

  mov r12, rdi
  mov r14, rsi

  loop_escape_blank:
  lea rsi, [SPACE_CHAR]
  mov dil, byte [r12]
  call ft_strchr
  test rax, rax
  je loop_escape_blank_end
  inc r12
  jmp loop_escape_blank
  loop_escape_blank_end:

  ; escape +, -
  loop_escape_sign:
  mov sil, byte [r12]
  cmp sil, 43; '+'
  je loop_escape_sign_increment
  cmp sil, 45; '-'
  je loop_escape_sign_increment
  jmp loop_escape_sign_end
  loop_escape_sign_increment:
  inc r12
  jmp loop_escape_sign
  loop_escape_sign_end:

  ; end_loop_escape_sign
  ; check if there is a number
  cmp byte [r12], 0
  je check_number_error

  ; set a pointer to the start of the number
  mov r13, r12

  loop_check_number_char:
  mov al, byte [r12]
  test al, al
  je loop_check_number_char_end
  inc r12
  mov dil, al
  mov rsi, r14
  call ft_strchr
  test rax, rax
  je check_number_error
  jmp loop_check_number_char
  
  loop_check_number_char_end:
  mov rax, r13
  pop r14
  pop r13
  pop r12
  ret

  check_number_error:
  pop r14
  pop r13
  pop r12
  mov rax, 0
  ret


; int			ft_atoi_base(char *str, char *base);
ft_atoi_base:
  push r12
  push r13
  push r14
  push r15
  push rbx

  mov r12, rdi; r12 = str
  mov r13, rsi; r13 = base

  ; check base
  mov rdi, r13
  call check_base
  cmp rax, -1
  je ft_atoi_base_error
  mov rbx, rax; store the length of the base on rbx

  ; sign
  mov rdi, 45; '-'
  mov rsi, r12
  call nb_char
  and rax, 1
  neg rax
  test rax, rax
  jne assign_sign
  mov rax, 1
  assign_sign:
  mov r14, rax; r14 = neg

  ; check number
  mov rdi, r12
  mov rsi, r13
  call check_number
  test rax, rax
  je ft_atoi_base_error
  mov r12, rax; r12 point now to the start of the number

  mov r15, 0; store the result in r15
  
  ft_atoi_base_loop:
  ; call ft_strchr
  mov al, byte [r12]
  test al, al
  je ft_atoi_base_end
  mov dil, byte [r12]
  mov rsi, r13
  call ft_strchr
  sub rax, r13; rax - base -> return the position of char in the base
  ; nb = nb * base_length + char_pos
  imul r15, rbx
  add r15, rax
  inc r12; str++
  jmp ft_atoi_base_loop



  ft_atoi_base_end:
  imul r15, r14
  mov rax, r15
  pop rbx
  pop r15
  pop r14
  pop r13
  pop r12
  ret

  ft_atoi_base_error:
  mov rax, 0
  pop rbx
  pop r15
  pop r14
  pop r13
  pop r12
  ret