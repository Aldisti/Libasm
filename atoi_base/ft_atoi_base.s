
section .note.GNU-stack
section .data:
	invalid_chars db "+ -",0
section .bss:
	result resq 1
	pow resq 1


section .text
	extern __errno_location
	global ft_strlen
	global ft_in
	global ft_chk_db
	global ft_chk_ch
	global ft_chk_base

; ft_strlen
; int	ft_strlen(char *)
; INPUT: rdi
; OUTPUT: rax

; ft_in: returns 1 if the char is in the string
; int	ft_in(char, char *)
; INPUT: rdi, rsi
; OUTPUT: rax

; ft_chk_db: assures that there is no double value in the string
; int	ft_chk_db(char *)
; INPUT: rdi
; OUTPUT: rax

; ft_chk_ch: assures that there are only valid values in the string
; int	ft_chk_ch(char *)
; INPUT: rdi
; OUTPUT: rax


; int	ft_strlen(char *: rdi)
; rdi, rax
ft_strlen:
	mov rax, 0
_start_strlen:
	cmp byte [rdi], 0
	jz _end_strlen
	inc rdi
	inc rax
	jmp _start_strlen
_end_strlen:
	ret


; int	ft_in(char: rdi, char *: rsi)
; rdi, rsi, rcx, rax
ft_in:
_start_in:
	mov cl, [rsi]
	cmp dil, cl
	je _end_true
	cmp cl, 0
	je _end_false
	inc rsi
	jmp _start_in


; int	ft_chk_db(char *: rdi)
; returns 1 if there is a double char otherwise 0
; rbi, rdx, rax
ft_chk_db:
	mov rdx, rdi
_start_db:
	mov dil, [rdx]
	cmp dil, 0
	je _end_false
	inc rdx
	mov rsi, rdx
	call ft_in
	cmp rax, 0
	jne _end_true
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
	jz _end_false
	mov rdi, [rcx]
	push rcx
	push rsi
	call ft_in
	pop rsi
	pop rcx
	cmp rax, 1
	je _end_true
	inc rcx
	jmp _start_ch


; some utils
_end_true:
	mov rax, 0
	mov al, 1
	ret
_end_false:
	mov rax, 0
	ret
_invalid_base:
	pop rbx
	mov rax, 1
	ret


; int	ft_chk_base(char *: rdi);
; returns 1 if the base is invalid 0 otherwise
; 
ft_chk_base:
	push rbx
	mov rbx, rdi

	call ft_strlen
	cmp rax, 1
	jle _invalid_base

	mov rdi, rbx
	call ft_chk_db
	cmp rax, 1
	je _invalid_base

	mov rdi, rbx
	call ft_chk_ch
	cmp rax, 1
	je _invalid_base

	pop rbx
	mov rax, 0
	ret


%macro push_state 0
	push rdi
	push rsi
	push rdx
	push rcx
%endmacro

%macro pop_state 0
	pop rdi
	pop rsi
	pop rdx
	pop rcx
%endmacro

; int	ft_strlen(char *: rdi)
; int	ft_in(char: rdi, char *: rsi)
; int	ft_chk_db(char *: rdi)
; int	ft_chk_ch(char *: rdi)
; int	ft_chk_base(char *: rdi);

ft_atoi_base:
	push rbx
	; TODO: check base
	; TODO: check str

	push rdi
	push rsi

	call ft_strlen
	mov rsi, ebp
	push rax
	call ft_strlen
	mov rcx, rax
	pop rdx

	pop rsi
	pop rdi

	; rax: result
	; rbx: i
	; rdi: str
	; rsi: base
	; rdx: str len
	; rcx: base len

	mov rax, 0
	mov rbx, 0

_start_loop:
	cmp byte [rdi+rbx*8], 0
	jz _end_loop

	; get index of rdi+rbx*8 in base
	; multiply both results
	; add to result

	; do rcx ** rbx ---------------
	push rax
	push_state

	mov rdi, rcx
	mov rsi, rbx
	call ft_pow

	pop_state
	pop r8

	add rax, r8 
	; -----------------------------

	

_end_loop:

	pop rbx
	ret

