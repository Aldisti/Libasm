
NAME	= a.out

SRC		= $(wildcard *.s)
OBJ		= $(SRC:%.s=%.o)
MAIN	= main.c

SCC		= nasm
SFLAGS	= -f elf64
RM		= rm -f

%.o : %.s
	@$(SCC) $(SFLAGS) $< -o $@

$(NAME): $(OBJ)
	@gcc -g $(MAIN) $(OBJ) -o $(NAME)

all: $(NAME)

clean:
	@$(RM) $(OBJ)

fclean: clean
	@$(RM) $(NAME)

exe: fclean $(NAME)
	@./$(NAME)
	@$(RM) $(OBJ)

leaks: fclean $(NAME)
	@valgrind --leak-check=full --show-leak-kinds=all ./$(NAME)
	@$(RM) $(OBJ)

re: fclean all

.PHONY: all clean fclean exe leaks re
