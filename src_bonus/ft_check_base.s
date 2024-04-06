
section .note.GNU-stack

section .data:
	invalid_chars db "+ -",0

section .text
	global ft_check_base
	extern ft_strlen
	extern ft_in

; rax:int	ft_check_base(rdi:char *base);
; returns 1 if the base is invalid 0 otherwise
ft_check_base:
	push rbx
	mov rbx, rdi

	call ft_strlen
	cmp eax, 1
	jle _invalid_base

	mov rdi, rbx
	call ft_chk_db
	cmp eax, 1
	je _invalid_base

	mov rdi, rbx
	call ft_chk_ch
	cmp eax, 1
	je _invalid_base

	mov rdi, rbx
	call ft_strlen

	pop rbx
	ret


; int	ft_chk_db(char *: rdi)
; returns 1 if there is a double char otherwise 0
; rbi, rdx, rax
ft_chk_db:
	mov rdx, rdi
_start_db:
	mov dil, [rdx]
	cmp dil, 0
	je __ret_false
	inc rdx
	mov rsi, rdx
	call ft_in
	cmp eax, 0
	jne __ret_true
	jmp _start_db


; int	ft_chk_ch(char *: rdi)
; returns 1 if there is an invalid char otherwise 0
; rdi, rsi, rax
; rcx, rdx
ft_chk_ch:
	lea rcx, [rel invalid_chars]
	mov rsi, rdi
_start_ch:
	cmp byte [rcx], 0
	jz __ret_false
	mov rdi, [rcx]
	push rcx
	push rsi
	call ft_in
	pop rsi
	pop rcx
	cmp eax, 1
	je __ret_true
	inc rcx
	jmp _start_ch


; some utils
_invalid_base:
	pop rbx
__ret_true:
	xor eax, eax
	mov al, 1
	ret
__ret_false:
	xor eax, eax
	ret

