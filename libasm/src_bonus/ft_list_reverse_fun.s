
section .note.GNU-stack

section .data

section .text
	global ft_list_reverse_fun

%macro is_null 1
	cmp %1, 0
	jz __end
%endmacro

; void	ft_list_reverse_fun(t_list *: rdi);
; rdi: first node
; rsi: next node
; rcx: last node
ft_list_reverse_fun:
	push rdi
	is_null rdi

	mov rsi, [rdi+8]
	xor rcx, rcx
__outer_loop:
	cmp rdi, rcx ; if the first elem is the last reversed
	je __end ; then end the function
__inner_loop:
	cmp rsi, rcx ; if the second elem is the last reversed
	je __middle ; then stop the inner loop and start a new outer loop

	; swap 2 values
	mov r8, [rdi] ; move rdi->data in r8
	mov r9, [rsi] ; move rsi->data in r9
	mov [rdi], r9 ; swap rdi->data with rsi->data
	mov [rsi], r8 ; swap rsi->data with rdi->data

	mov rdi, [rdi+8] ; move in rdi the next node
	mov rsi, [rsi+8] ; move in rsi the next node

	jmp __inner_loop ; start inner loop again
__middle:
	mov rcx, rdi ; mov the last reversend elem in rcx
	mov rdi, [rsp] ; get the first elem of the list
	mov rsi, [rdi+8] ; get the second elem of the list
	jmp __outer_loop ; start outer loop again
__end:
	pop rdi
	ret

