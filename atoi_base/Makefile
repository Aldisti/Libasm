
NAME	= atoi_base

$(NAME): fclean
	@nasm -f elf64 *.s && gcc *.c *.o -o $(NAME)
	@./$(NAME)

all: $(NAME)

fclean:
	@rm -f *.o $(NAME)

