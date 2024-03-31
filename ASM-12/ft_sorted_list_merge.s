
section .note.GNU-stack

section .data

section .text
	global ft_sorted_list_merge
	extern ft_sorted_list_insert
	extern print_list

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
	mov r11, [rsp]
	before_call
	mov rdi, [r11]
	call print_list wrt ..plt
	after_call
	before_call
	call print_list wrt ..plt
	after_call
	before_call
	mov rdi, rsi
	call print_list wrt ..plt
	after_call
%endmacro


; void	ft_sorted_list_merge(t_list: rdi **, t_list: rsi *, int: rdx (*)(*, *));
; rsp: head
; rdi: begin primary
; rsi: begin second
; rdx: cmp function
ft_sorted_list_merge:
	push rdi

	is_null rdi
	is_null rsi
	is_null rdx

	mov rdi, [rdi] ; move begin primary in rdi

	cmp rdi, 0 ; if begin primary is null return begin second
	jz __return_second

__check_first:
	before_call
	mov rdi, [rdi]
	mov rsi, [rsi]
	call rdx
	after_call

	cmp eax, 0
	jg __first

__start:
	is_null rsi ; if the second list is empty
	cmp qword [rdi+8], 0 ; after cycling the first list append the second to it
	jz __append_all

	before_call
	mov rdi, [rdi+8]
	mov rdi, [rdi]
	mov rsi, [rsi]
	xor rax, rax
	call rdx
	after_call

	cmp eax, 0
	jle __next

	mov r8, rsi ; put begin second in tmp
	mov rsi, [rsi+8] ; go next in the second list

	mov r9, [rdi+8] ; put the next elem of begin primary in tmp
	mov [r8+8], r9 ; put the tmp as next elem of the node to insert
	mov [rdi+8], r8 ; insert the node
__next:
	mov rdi, [rdi+8]
	jmp __start

__end:
	pop rdi
	ret

__return_second:
	mov [rdi], rsi
	jmp __end

__first:
	mov r8, rsi ; put begin second in tmp
	mov rsi, [rsi+8] ; go to next elem on rsi

	mov [r8+8], rdi ; set begin primary as next elem of the node to insert
	mov r9, [rsp] ; get head of the list
	mov [r9], r8 ; set r8 as first elem of the list

	mov rdi, r8 ; set begin primary to the new node
	
	jmp __check_first

__append_all:
	mov [rdi+8], rsi
	jmp __end

