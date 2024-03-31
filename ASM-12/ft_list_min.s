
section .note.GNU-stack

section .data

section .text
	global ft_list_min

%macro before_call 0
	push rcx
	push rdx
	push r8
%endmacro

%macro after_call 0
	pop r8
	pop rdx
	pop rcx
%endmacro

; t_list	*ft_list_min(t_list *: rdi, int: rsi (*)(*, *));
; rcx: node
; rdx: smallest node
;  r8: cmp function
ft_list_min:
	mov rdx, rdi

	cmp rdi, 0
	jz __end

	mov rcx, [rdi+8]
	mov r8, rsi

__start:
	cmp rcx, 0
	jz __end

	before_call
	mov rdi, [rdx]
	mov rsi, [rcx]
	call r8
	after_call

	cmp dword eax, 0
	jle __next

	mov rdx, rcx

__next:
	mov rcx, [rcx+8]
	jmp __start
__end:
	mov rax, rdx
	ret

