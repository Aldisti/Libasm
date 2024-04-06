
; $> nasm -f elf64 *.o

section .note.GNU-stack

section .text
	global ft_strlen

; INPUT
; rdi: pointer to string
; RUNTIME
; rax: used to keep count
; rbx:
; rcx:
; rdx:
; rsi:
; rdi:
; OUTPUT
; rax: the string length
ft_strlen:
	mov rax, 0
__start:
	cmp byte [rdi], 0
	je _end
	inc rdi
	inc rax
	jmp __start
_end:
	ret

