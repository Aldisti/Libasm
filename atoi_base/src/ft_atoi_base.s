
section .note.GNU-stack

section .text
	global ft_atoi_base
	extern ft_isspace
	extern ft_strlen
	extern ft_in
	extern ft_numlen
	extern ft_pow
	extern ft_check_base
	extern ft_index

%macro be_call 0
	push rdi
	push rsi
	push rcx
	push rdx
%endmacro

%macro af_call 0
	pop rdx
	pop rcx
	pop rsi
	pop rdi
%endmacro

; rax: int	ft_atoi_base(rdi:char *num, rsi:char *base);
; rdi -> number
; rsi -> base
; rcx -> result
; rdx -> sign
; rbx -> nlen (number length)
; r12 -> blen (base length)
ft_atoi_base:
	push rbx
	push r12

	xor rbx, rbx ; init nlen to 0
	xor rcx, rcx ; init result to 0
	xor rdx, rdx ; init sign to 0
	xor r12, r12 ; init blen to 0

	cmp rdi, 0 ; if num is NULL return
	jz __end
	cmp rsi, 0 ; if base is NULL return
	jz __end

	mov edx, 1 ; sign starts positive

	be_call
	mov rdi, rsi ; put base as first param
	call ft_check_base
	af_call

	cmp eax, 2 ; if check_base return is lower than 2 return
	jl __end

	mov r12d, eax ; save check_base return in blen

__skip_spaces:
	be_call
	mov rdi, [rdi] ; this is like `ft_isspace(num[i])`
	call ft_isspace
	af_call

	cmp eax, 0 ; stop the cycle when `num[i]` isn't a space
	jz __check_sign

	inc rdi ; `i++`
	jmp __skip_spaces

__check_sign:
	cmp BYTE [rdi], 43 ; `if str[i] == '+'`
	je __plus_sign
	cmp BYTE [rdi], 45 ; `if str[i] == '-'`
	je __minus_sign

	jmp __num_length

__minus_sign:
	neg edx ; this should be like `sign = -sign`
__plus_sign:
	inc rdi ; `i++`
	jmp __check_sign

__num_length:
	be_call
	call ft_numlen ; calculate nlen
	af_call

	mov ebx, eax ; save the return value in nlen

__start:
b0:
	cmp ebx, 0 ; if rbx is 0 stop the cycle
	jz __end
	dec ebx ; `blen--`

b1:
	be_call
	mov edi, r12d ; put blen as first param
	mov esi, ebx ; put nlen as second param
	call ft_pow ; `ft_pow(blen, nlen)`
	af_call

	mov r11d, eax ; save the power result in tmp

	be_call
	mov rdi, [rdi]
	call ft_index
	af_call

	cmp eax, 0
	js __end

;	xor r11d, r11d ; set tmp to 0
;	mov r11b, [rdi] ; move `num[i]` in tmp
;	sub r11b, 48 ; subtract 48 to tmp
	imul eax, r11d ; multiply tmp times `ft_pow(blen, nlen)`

b4:
	add ecx, eax ; add the product to result

b5:
	inc rdi
	jmp __start

__end:
	pop r12
	pop rbx

	imul ecx, edx ; multiply result by sign
	mov eax, ecx ; return result

	ret

