
section .note.GNU-stack

section .data

section .text
	global ft_list_push_front
	extern ft_create_elem

; t_list *: rax	ft_create_elem(void *: rdi);

; void			ft_list_push_front(t_list **: rdi, void *: rsi);
ft_list_push_front:
	cmp qword rdi, 0 ; if the memory address is null only return
	jz _end
	push rdi ; preserve the list head
	mov rdi, rsi ; move data to rdi to make the call
	call ft_create_elem
	pop rdi
	cmp rax, 0 ; if malloc failed return
	jz _end
	mov rcx, [rdi] ; copy the head value in a tmp register
	mov qword [rax+8*1], rcx ; place the old head as next of the new head
	mov qword [rdi], rax ; insert the new head as head
_end:
	ret

