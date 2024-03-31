
section .note.GNU-stack

section .data

section .text
	global ft_list_find

%macro is_null 1
	cmp %1, 0
	jz __error
%endmacro

%macro before_call 0
	push rdi
	push rsi
	push rdx
%endmacro

%macro after_call 0
	pop rdx
	pop rsi
	pop rdi
%endmacro

; t_list	*ft_list_find(t_list *, void *, int (*)());
; rdi	begin_list
; rsi	data_ref
; rdx	cmp
ft_list_find:
	is_null rsi
	is_null rdx
__start:
	is_null rdi

	before_call
	mov rdi, [rdi]
	mov rsi, rsi
	call rdx
	after_call

	cmp rax, 0
	jnz __next

	mov rax, rdi
	jmp __end

__next:
	mov rdi, [rdi+8]
	jmp __start
__error:
	xor rax, rax
__end:
	ret

