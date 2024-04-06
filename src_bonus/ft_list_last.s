
section .note.GNU-stack

section .data

section .text
	global ft_list_last

; t_list *: rax	ft_list_last(t_list *: rdi);
ft_list_last:
	mov rax, rdi
	cmp rax, 0
	jz _end
__start:
	cmp qword [rax+8], 0
	jz _end
	mov rax, [rax+8]
	jmp __start
_end:
	ret

