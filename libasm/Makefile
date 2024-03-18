# this is to test read

NAME	= libasm

SRC		= $(wildcard src/*s)
OBJ		= $(SRC:%s=%o)
MAIN	= src/main.c

SCC		= nasm
SFLAGS	= -f elf64
RM		= rm -f


%.o : %.s
	@$(SCC) $(SFLAGS) $< -o $@

$(NAME): $(OBJ)
	@gcc $(MAIN) $(OBJ) -o $(NAME)

all: $(NAME)

clean:
	@$(RM) $(OBJ)

fclean: clean
	@$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re

