
section .data
	text db "Hello with some length",10,0

section .text
	global _start

_start:
	mov rax, text
	call _print

	mov rax, 60
	mov rdi, 0
	syscall

; input: rax as pointer to string
; output: print string in rax
_print:
	push rax
	mov rbx, 0
_printLoop:
	inc rax
	inc rbx
	mov cl, [rax]
	cmp cl, 0
	jnz _printLoop

	mov rax, 1
	mov rdi, 1
	pop rsi
	mov rdx, rbx
	syscall

	ret

