
section .note.GNU-stack

section .data

section .text
	global ft_list_reverse

; void	ft_list_reverse(t_list **: rdi);
ft_list_reverse:

	xor r8, r8 ; a
	mov r9, [rdi] ; b
	mov r10, [r9+8] ; c
__start:
	mov [r9+8], r8
	mov r8, r9
	mov r9, r10

	cmp r9, 0
	jz _end

	mov r10, [r10+8]
	jmp __start
_end:
	mov [rdi], r8
	ret

