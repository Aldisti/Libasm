
section .note.GNU-stack

section .data

section .text
	global ft_list_foreach_if

%macro before_call 0
	push rdi
	push rsi
	push rdx
	push rcx
%endmacro

%macro after_call 0
	pop rcx
	pop rdx
	pop rsi
	pop rdi
%endmacro

; void ft_list_foreach_if(t_list *, void (*)(void *), void *, int (*)(*, *))
; rdi	begin_list
; rsi	f
; rdx	data_ref
; rcx	cmp
ft_list_foreach_if:
	cmp rdi, 0
	jz __end
	cmp rdi, rsi
	je __end
	cmp rdx, 0
	jz __end
	cmp rdx, rcx
	je __end
__start:
	before_call
	mov rdi, [rdi]
	mov rsi, rdx
	call rcx
	after_call

	cmp rax, 0
	jz __next

	before_call
	mov rdi, [rdi]
	call rsi
	after_call
__next:
	mov rdi, [rdi+8]

	cmp rdi, 0
	jnz __start
__end:
	ret

