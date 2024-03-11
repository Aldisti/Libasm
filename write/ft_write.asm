
; nasm -f elf64 *.asm
; gcc main.c *.o

extern __errno_location

section .note.GNU-stack

section .text
	global ft_write

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
ft_write:
	mov rax, 1
	; rdi already set
	; rsi already set
	; rdx already set
	syscall
	cmp rax, 0
	jl _syscallFail
	ret

_syscallFail:
	neg rax
	push rax
	call __errno_location
	pop qword [rax]
	mov rax, -1
	ret

