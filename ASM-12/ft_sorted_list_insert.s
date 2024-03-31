
section .note.GNU-stack

section .data

section .text
	global ft_sorted_list_insert
	extern print_list
	extern ft_create_elem
	extern ft_list_push_front

%macro is_null 1
	cmp %1, 0
	jz __end
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

%macro debug 0
	before_call
	call print_list wrt ..plt
	after_call
%endmacro


; void	ft_sorted_list_insert(t_list: rdi **, void: rsi *, int: rdx (*)(*, *));
; rdi: begin
; rsi: data
; rdx: cmp function
ft_sorted_list_insert:
	push rdi
b0:

	is_null rdi
	is_null rdx

	mov rdi, [rdi]; move in rdi the first elem of the list
	cmp rdi, 0 ; if the first elem of the list is 0
	jz __first ; than add the new elem to the begin of the list

	before_call
	mov rdi, [rdi]
	call rdx ; call the cmp function
	after_call

	cmp eax, 0 ; if the first elem is bigger than the one to add
	jns __first ; then push to the front the new elem

	before_call
	mov rdi, rsi
	call ft_create_elem ; create a node from the data to insert
	after_call

	mov rsi, rax
	cmp rsi, 0 ; if malloc fails
	jz __end ; then return

__start:
	cmp qword [rdi+8], 0
	jz __append

	before_call
	mov rdi, [rdi+8]
	mov rdi, [rdi]
	mov rsi, [rsi]
	call rdx
	after_call

	cmp eax, 0
	jl __next

__append:
	mov r8, [rdi+8]
	mov [rsi+8], r8
	mov qword [rdi+8], rsi
	jmp __end

__next:
	mov rdi, [rdi+8]
	jmp __start

__end:
	pop rdi
	ret

__first:
	mov rdi, [rsp]
	call ft_list_push_front
	jmp __end

