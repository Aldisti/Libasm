
section .note.GNU-stack

section .data

section .text
	global ft_list_foreach

; void	ft_list_foreach(t_list *: rdi, void *: rsi);
ft_list_foreach:
	cmp rdi, 0
	jz _end
	cmp rdi, rsi
	je _end

__start:
	push rdi
	push rsi

	mov rdi, [rdi]
	call rsi

	pop rsi
	pop rdi

	mov rdi, [rdi+8]

	cmp rdi, 0
	jnz __start
_end:
	ret

