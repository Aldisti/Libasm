
section .note.GNU-stack

section .data

section .text
	global ft_list_push_back
	extern ft_list_last
	extern ft_create_elem

; t_list *: rax	ft_list_last(t_list *: rdi);
; t_list *: rax	ft_create_elem(void *: rdi);

; void			ft_list_push_back(t_list **: rdi, void *: rsi);
ft_list_push_back:

	cmp rdi, 0 ; check if rdi is null
	jz _end

	; create the new element to push into the list
	push rdi
	mov rdi, rsi
	call ft_create_elem
	pop rdi
	cmp rax, 0
	jz _end

	push rdi
	push rax
	; get the last element of the list
	mov rdi, [rdi]
	call ft_list_last
	pop rcx
	pop rdi

	; if the list is empty add the new node as head
	cmp rax, 0
	jz _push_head

	; make the new node as next of the last element of the list
	mov	qword [rax+8*1], rcx
_end:
	ret

_push_head:
	mov [rdi], rcx
	jmp _end

