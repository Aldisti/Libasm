
section .note.GNU-stack

section .data

section .text
	global ft_list_remove_if
	extern free

%macro is_null 1
	cmp %1, 0
	jz __end
%endmacro

%macro before_call 0
	push rdi
	push rsi
	push rdx
	push rcx
	push r11
%endmacro

%macro after_call 0
	pop r11
	pop rcx
	pop rdx
	pop rsi
	pop rdi
%endmacro


; void ft_list_remove_if(t_list **, void (*)(void *), void *, int (*)(*, *), void (*)(void *))
; r11	element before rdi, if it exists
; rdi	begin_list
; rsi	data_ref
; rdx	cmp
; rcx	free_fct
ft_list_remove_if:
	is_null rdi
	is_null rsi
	is_null rcx

	push rdi ; push begin_list address to stack
	mov rdi, [rdi] ; move begin_list into rdi
	xor r11, r11 ; set to zero r11
__start:
	jmp __check_node
__check_first:
	mov r8, [rsp] ; move begin_list address into r8
	cmp [r8], rdi ; check if rdi is the begin_list
	je __delete_first ; if it is go to delete_first
__delete_elem:
	mov r8, [rdi+8]
	mov [r11+8], r8

	before_call
	mov rdi, [rdi]
	call rcx
	after_call

	before_call
	call free wrt ..plt
	after_call

	mov rdi, [r11+8]
__next:
	is_null rdi
	mov r11, rdi
	mov rdi, [rdi+8]
	cmp rdi, 0
	jnz __start
__end:
	pop rdi
	ret


__check_node:
	is_null rdi
	before_call
	mov rdi, [rdi] ; move rdi->data in rdi
	call rdx ; call to cmp
	after_call
	cmp rax, 0
	jnz __next
	jmp __check_first

__delete_first:
	mov r10, [rdi+8] ; move the second elem of the list into r10
	mov [r8], r10 ; set r10 as begin list

	mov r11, rdi ; move elem to delete into r11
	mov r8, rdi ; move elem to delete also into r8
	mov rdi, r10 ; set rdi as the begin list

	before_call
	mov rdi, [r8] ; move in rdi data of elem to delete
	call rcx ; call to free_fct
	after_call

	before_call
	mov rdi, r11 ; move in rdi the elem to delete
	call free wrt ..plt
	after_call

	jmp __start ; loop again

