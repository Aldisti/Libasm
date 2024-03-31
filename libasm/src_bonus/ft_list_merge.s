
section .note.GNU-stack

section .data

section .text
	global ft_list_merge
	extern ft_list_last

; t_list *: rax	ft_list_last(t_list *: rdi);

; void	ft_list_merge(t_list **: rdi, t_list *: rsi);
ft_list_merge:
	cmp rdi, 0
	jz __end
	cmp rsi, 0
	jz __end

	push rdi
	push rsi

	mov rdi, [rdi]
	call ft_list_last
	pop rsi
	pop rdi

	cmp rax, 0
	jz __push_head

	mov	qword [rax+8], rsi
__end:
	ret

__push_head:
	mov [rdi], rsi
	jmp __end

