
; nasm -f elf64 *.asm
; gcc main.c *.o

section .note.GNU-stack

section .text
	global ft_read

; INPUT
; rdi: (int) fd
; rsi: (void *) buf
; rdx: (size_t) count
; RUNTIME
; rax:
; rbx:
; rcx:
; rdi: X
; rsi: X
; rdx: X
; OUTPUT
; rax: number of bytes written
ft_read:
	mov rax, 0
	; rdi already set
	; rsi already set
	; rdx already set
	syscall
	ret

