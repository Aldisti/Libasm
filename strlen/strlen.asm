

; Compile the file with:
; $> nasm -f elf64 -o hello.o hello.asm
; Make the executable:
; $> ld hello.o -o hello

section .text
	global ft_strlen

ft_strlen:
	push rbx
	mov rbx, 0
	cmp byte [rdi], 0
	je _endLoop
_startLoop:
	inc rdi
	inc rbx
	mov cl, [rdi]
	cmp cl, 0
	jne _startLoop
_endLoop:
	mov rax, rbx
	pop rbx
	ret

