
section .note.GNU-stack

section .data

section .text
	global ft_list_sort
	extern ft_list_min
	extern ft_list_pop
	extern print_list

%macro is_null 1
	cmp %1, 0
	jz __end
%endmacro

%macro before_call 0
	push rdi
	push rsi
	push rcx
%endmacro

%macro after_call 0
	pop rcx
	pop rsi
	pop rdi
%endmacro

%macro debug 0
	before_call
	call print_list wrt ..plt
	after_call
%endmacro

; t_list	*ft_list_min(t_list *, int (*)(*, *));
; void		ft_list_pop(t_list **: rdi, t_list *:rsi);

; void		ft_list_sort(t_list **: rdi, int (*)(*, *): rsi);
; rdi: last ordered node
; rsi: cmp function
; rcx: start smallest search
; rsp: head [STACK]
ft_list_sort:
	push rdi

	is_null rdi
	is_null rsi

	mov rdi, [rdi]
	mov rcx, rdi
__start:
;	debug
	is_null rdi
	cmp qword [rcx+8], 0
	jz __end
	is_null rcx ; end of the list

	before_call
	mov rdi, rcx ; search the smallest node starting from rcx
	call ft_list_min
	after_call

	cmp rax, rcx ; if the smallest node is already in order skip it
	je __next
	mov rdx, [rsp] ; get head temporarly

	push rax ; save smallest node for later
	before_call
	mov rdi, rdx
	mov rsi, rax
	call ft_list_pop
	after_call
	pop rax ; get back the smallest node

	is_null rax ; idk why, but it works
	cmp rdi, rcx
	je __first

	mov [rax+8], rcx
	mov [rdi+8], rax
;	debug
__next:
	mov rdi, [rdi+8]
	mov rcx, [rdi+8]
	jmp __start
__end:
	pop rdi
	ret

__first:
	mov rdx, [rsp]
	mov [rax+8], rcx
	mov [rdx], rax
	mov rdi, rax
	jmp __start

; P.S.
; the algorithm used in this function to
; sort the list is the "Selection Sort"

