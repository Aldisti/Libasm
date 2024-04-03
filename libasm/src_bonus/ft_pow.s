
section .note.GNU-stack

section .text
	global ft_pow

; rax: int	ft_pow(rdi:int n, rsi:int e);
ft_pow:
	xor eax, eax

	cmp esi, 0
	jl __end

	mov eax, 1 ; mov or inc, what should I use?
__start:
	cmp esi, 0
	jz __end

	imul eax, edi

	dec esi

	jmp __start
__end:
	ret

