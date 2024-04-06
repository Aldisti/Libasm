
section .note.GNU-stack

section .text
	global ft_index

; rax: int	ft_index(rdi:char c, rsi:char *base);
ft_index:
	xor eax, eax

__start:
	cmp dil, 0
	jz __end
	cmp dil, [rsi]
	je __ret

	inc rsi
	inc eax
	jmp __start

__end:
	mov eax, -1
__ret:
	ret

