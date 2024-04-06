
section .note.GNU-stack

section .text
	global ft_strlen

; rax:size_t	ft_strlen(rdi:char *str);
ft_strlen:
	xor eax, eax

	cmp rdi, 0
	jz __ret

__start:
	cmp BYTE [rdi], 0
	jz __ret

	inc eax
	inc rdi
	jmp __start

__ret:
	ret

