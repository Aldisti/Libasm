

; Compile the file with:
; $> nasm -f elf64 -o hello.o hello.asm
; Make the executable:
; $> ld hello.o -o hello

section .text
	global ft_strcpy

; INPUT
; rdi: (char *) is the destination
; rsi: (char *) is the source
; RUNTIME
; rax: used to write dst
; rbx: bl: (char) used as tmp
; rcx:
; rdi:
; rsi: used to read src
; OUTPUT
; rax: (char *) is the destination
ft_strcpy:
	push rbx
	mov rax, rdi
	push rdi

_startLoop:
	mov bl, [rsi]
	mov [rax], bl
	inc rax
	inc rsi
	cmp byte [rsi], 0
	jne _startLoop
_endLoop:

	pop rax
	pop rbx
	ret

