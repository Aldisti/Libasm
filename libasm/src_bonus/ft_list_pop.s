

section .note.GNU-stack

section .data

section .text
	global ft_list_pop

%macro is_null 1
	cmp qword %1, 0
	jz __end
%endmacro

; void	ft_list_pop(t_list **: rdi, t_list *:rsi);
; rdi: head
; rsi: node to pop
; rcx: node
; rdx: tmp node
ft_list_pop:
	is_null rdi
	is_null rsi

	cmp [rdi], rsi
	je __first

	mov rcx, [rdi]
__start:
	is_null [rcx+8]

	cmp [rcx+8], rsi
	jne __next

	mov rdx, [rsi+8]
	mov [rcx+8], rdx
	jmp __end
__next:
	mov rcx, [rcx+8]
	jmp __start
__end:
	ret

__first:
	mov rdx, [rsi+8]
	mov [rdi], rdx
	ret
