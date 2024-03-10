

; Compile the file with:
; $> nasm -f elf64 -o hello.o hello.asm
; Make the executable:
; $> ld hello.o -o hello

section .note.GNU-stack

section .data
	newline db 10

section .text
	global ft_strcmp

%macro before_syscall 0
	push rax
	push rdi
	push rsi
	push rdx
%endmacro

%macro after_syscall 0
	pop rdx
	pop rsi
	pop rdi
	pop rax
%endmacro

%macro putchar 1
	mov bh, %1
	before_syscall
	mov rax, 1
	mov rdi, 1
	mov rsi, rbx
	mov rdx, 1
	syscall
	after_syscall
%endmacro

; INPUT
; rdi: (qword) is s1
; rsi: (qword) is s2
; RUNTIME
; rax: used as tmp
; rbx:
; rcx:
; rdi: as in input
; rsi: as in input
; OUTPUT
; rax: (byte) is the difference
ft_strcmp:
_startLoop:
	mov rax, 0
	mov rbx, 0
	mov byte ah, [rdi]
	mov byte bh, [rsi]
	cmp byte rax, rbx
_break1:
	jne _endLoop
	; check if rdi has reached 0
	cmp byte [rdi], 0
	jz _endLoop
	; check if rsi has reached 0
	cmp byte [rsi], 0
	jz _endLoop
	; continue loop
_break2:
	inc rdi
	inc rsi
	jmp _startLoop
_endLoop:
_break3:
	mov qword rax, 0
	mov qword rbx, 0
_break4:
	mov byte al, [rdi]
	mov byte bl, [rsi]
_break5:
	sub rax, rbx
_break6:
	ret

