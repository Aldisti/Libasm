
section .note.GNU-stack

section .data

section .text
	global ft_list_clear

; void	ft_list_clear(t_list *: rdi, void *: rsi);
ft_list_clear:
_start:

	push qword [rdi+8*1]
	push rsi

	call rsi

	pop rsi
	pop rdi

	cmp rdi, 0
	jnz _start
_end:
	ret

