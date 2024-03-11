
; nasm -f elf64 *.asm
; gcc -no-pie main.c *.o

extern __errno_location

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

