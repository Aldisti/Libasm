
section .note.GNU-stack

section .data

section .text
	global ft_list_size

; int: rax	ft_list_size(t_list *: rdi);
ft_list_size:
	xor rax, rax
	cmp rdi, 0
	jz _end
__start:
	inc rax
	cmp qword [rdi+8], 0
	jz _end
	mov rdi, [rdi+8]
	jmp __start
_end:
	ret

