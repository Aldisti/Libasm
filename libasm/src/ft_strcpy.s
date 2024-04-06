

; Compile the file with:
; $> nasm -f elf64 -o hello.o hello.asm
; Make the executable:
; $> ld hello.o -o hello

section .note.GNU-stack

section .text
	global ft_strcpy

; INPUT
; rdi: is the destination
; rsi: is the source
; RUNTIME
; rax: used to write dst
; rbx: used as tmp
; rcx:
; rdi:
; rdx:
; rsi: used to read src
; OUTPUT
; rax: is the destination
ft_strcpy:
	push rbx
	mov rax, rdi
	push rdi

__start:
	mov bl, [rsi]
	mov [rax], bl
	cmp byte [rsi], 0
	je _end
	inc rax
	inc rsi
	jmp __start
_end:
	pop rax
	pop rbx
	ret

