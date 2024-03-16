
; nasm -f elf64 *.asm
; gcc -no-pie main.c *.o

section .note.GNU-stack

section .text
	global ft_strdup
	extern malloc

; INPUT
; rdi: pointer to string to dup
; RUNTIME
; rax: used to keep the dup string
; rbx: used to keep the string size
; rcx: used as tmp
; rdi: used to keep the string to dup
; rsi:
; rdx:
; OUTPUT
; rax: pointer to dup string
ft_strdup:
	push rbx

	push rdi
	mov rbx, 0
_start_strlen:
	inc rbx
	cmp byte [rdi], 0
	je _end_strlen
	inc rdi
	jmp _start_strlen
_end_strlen:
	; allocate rbx bytes with malloc
	mov rdi, rbx
	call malloc wrt ..plt
	pop rdi
	
	cmp rax, 0
	je _end

	push rax
_start_copy:
	mov rcx, 0
	mov cl, [rdi]
	mov [rax], cl
	cmp byte [rdi], 0
	je _end_copy
	inc rdi
	inc rax
	jmp _start_copy
_end_copy:
	pop rax

_end:
	pop rbx
	ret

