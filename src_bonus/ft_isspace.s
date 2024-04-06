
section .note.GNU-stack

section .text
	global ft_isspace

; rax:int	ft_isspace(rdi:char c)
ft_isspace:
	xor eax, eax

	cmp dil, 32
	je __ret_true

	cmp dil, 13
	jg __ret_false

	cmp dil, 9
	jl __ret_false

__ret_true:
	mov eax, 1
__ret_false:
	ret

