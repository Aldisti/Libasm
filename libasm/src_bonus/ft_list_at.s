
section .note.GNU-stack

section .data

section .text
	global ft_list_at

; t_list	*ft_list_at(t_list *: rdi, int: rsi);
ft_list_at:
	mov rax, rdi ; move rdi into rax so it's ready to return
_start:
	cmp rsi, 0 ; if we reached the rsi'th value return
	jz _end
	cmp rax, 0 ; if we reached the end of the list return
	jz _end

	mov rax, [rax+8] ; do node=node->next
	dec rsi
	jmp _start
_end:
	ret

