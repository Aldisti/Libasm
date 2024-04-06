
; nasm -f elf64 *.asm
; gcc main.c *.o

section .note.GNU-stack

section .text
	global ft_strcmp

; INPUT
; rdi: (qword) is s1
; rsi: (qword) is s2
; RUNTIME
; rax: used as tmp
; rbx: used as tmp
; rcx:
; rdi: as in input
; rsi: as in input
; OUTPUT
; rax: (byte) is the difference
ft_strcmp:
_start_loop:
	; set rax and rbx to 0
	mov rax, 0
	mov rbx, 0
	; copy the char value in the rightmost byte of rax and rbx
	mov byte al, [rdi]
	mov byte bl, [rsi]

	; main condition
	sub rax, rbx
	cmp rax, 0
	jne _end_loop

	; check if rdi has reached 0
	cmp byte [rdi], 0
	jz _end_loop
	; check if rsi has reached 0
	cmp byte [rsi], 0
	jz _end_loop

	; continue the loop
	inc rdi
	inc rsi
	jmp _start_loop
_end_loop:
	ret

