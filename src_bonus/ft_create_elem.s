
section .note.GNU-stack

section .data

section .text
	global ft_create_elem
	extern malloc

; void *: rax	malloc(size_t: rdi);

; t_list *: rax	ft_create_elem(void *: rdi);
ft_create_elem:
	push rdi
	mov rdi, 8*2 ; 8*2 should be the size of the struct
	call malloc wrt ..plt
	pop rdi
	cmp rax, 0 ; if malloc returns 0
	jz _end ; return 0
	mov qword [rax+8*0], rdi ; move data (rdi) in the first 8 bytes
	mov qword [rax+8*1], 0 ; set to NULL the second 8 bytes
_end:
	ret

