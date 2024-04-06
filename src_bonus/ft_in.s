
section .note.GNU-stack

section .text
	global ft_in

; rax:int	ft_in(rdi:char c, rsi:char *str);
ft_in:
	xor eax, eax
__start:
	cmp BYTE dil, [rsi]
	je __ret_true
	cmp BYTE [rsi], 0
	je __ret_false
	inc rsi
	jmp __start
__ret_true:
	mov eax, 1
__ret_false:
	ret

