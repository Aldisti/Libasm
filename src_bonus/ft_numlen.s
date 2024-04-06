
section .note.GNU-stack

section .text
	global ft_numlen
	extern ft_in

%macro is_null 1
	cmp %1, 0
	jz __end
%endmacro

%macro be_call 0
	push rdi
	push rsi
	push rcx
%endmacro

%macro af_call 0
	pop rcx
	pop rsi
	pop rdi
%endmacro

; rax:int	ft_numlen(rdi:char *num, rsi:char *base);
ft_numlen:
	xor ecx, ecx

	is_null rdi
	is_null rsi

__start:
	cmp BYTE [rdi], 0
	jz __end

	be_call
	mov rdi, [rdi]
	call ft_in
	af_call

	is_null eax

	inc ecx
	inc rdi
	jmp __start

__end:
	mov eax, ecx
	ret

