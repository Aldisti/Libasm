
STDIN equ 0
STDOUT equ 1

section .data
	text db "Hello with some length",10,0

section .text
	global _start
	global _ft_strlen

%macro exit 1
	mov rdi, %1
	call _exit
%endmacro

_start:
	exit 0

_ft_strlen:
	mov rax, edi
	push rax
	mov rbx, 0
_loop:
	inc rax
	inc rbx
	mov cl, [rax]
	jnz _loop

	mov eax, rax

	ret

_exit:
	mov rax, 60
	syscall

