
section .note.GNU-stack

section .data
	head dq 0

section .text
	global ft_list_push_strs
	extern ft_list_push_back

; void: rax		ft_list_push_back(t_list **: rdi, void *: rdi);

; t_list *: rax	ft_list_push_strs(int: rdi, char **: rsi);
ft_list_push_strs:
	push rbx
	push rdi ; save the size in the stack

	mov rcx, rsi ; move the strings array into rcx
	xor rbx, rbx ; initialize rbx to 0

__start:
	cmp qword rbx, [rsp] ; check if we pushed all strings
	je _end

	push rcx ; save the array of strings address for next cycle

	lea rdi, [rel head] ; load the memory address of head into rdi
	mov rsi, [rcx+rbx*8] ; put the next string address into rsi
	call ft_list_push_back ; make the call

	pop rcx ; retrieve the array of strings

	inc rbx
	jmp __start
_end:
	pop rdi
	pop rbx

	mov qword rax, [rel head]
	ret

