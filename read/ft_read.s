
; nasm -f elf64 *.asm
; gcc -no-pie main.c *.o


section .note.GNU-stack
section .data:
section .text
	global ft_read
	extern __errno_location

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
	jl _syscall_fail
	ret

_syscall_fail:
	neg rax
	push rax
	call __errno_location wrt ..plt
	pop qword [rax]
	mov rax, -1
	ret

