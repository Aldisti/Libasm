

; Compile the file with:
; $> nasm -f elf64 -o hello.o hello.asm
; Make the executable:
; $> ld hello.o -o hello

section .data
	text db "Hello, World!", 10

section .text
	global _foo

_foo:
	mov rax, 1
	mov rdi, 1
	mov rsi, text
	mov rdx, 14
	syscall

	mov rax, 60
	mov rdi, 42
	syscall

	mov rax, 42
	ret

