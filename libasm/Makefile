# this is to test read

NAME	= libasm.a

SRCDIR	= src
OBJDIR	= obj

BSRCDIR	= src_bonus
BOBJDIR	= obj_bonus

SRCS	= $(wildcard $(SRCDIR)/*.s)
OBJS	= $(subst $(SRCDIR), $(OBJDIR), $(SRCS:%.s=%.o))

BSRCS	= $(wildcard $(BSRCDIR)/*.s)
BOBJS	= $(subst $(BSRCDIR), $(BOBJDIR), $(BSRCS:%.s=%.o))

MAIN	= src/main.c

SC		= nasm
SFLAGS	= -f elf64

CC		= gcc
CFLAGS	= -Wall -Wextra -Werror

RM		= rm -f
RMDIR	= rm -rf

#############
### RULES ###
#############

$(NAME): $(OBJS)
	ar rcs $(NAME) $(OBJS)
	$(CC) $(CFLAGS) $(MAIN) $(NAME)

all: $(NAME)

$(OBJDIR):
	@mkdir -p $@

$(OBJDIR)/%.o : $(SRCDIR)/%.s | $(OBJDIR)
	$(SC) $(SFLAGS) $< -o $@

$(BOBJDIR)/%.o : $(BSRCDIR)/%.s
	@$(SC) $(SFLAGS) $< -o $@

clean:
	@$(RM) $(OBJS)

fclean: clean
	@$(RM) $(NAME) a.out
	@$(RMDIR) $(OBJDIR) $(BOBJDIR)

re: fclean all

.PHONY: all clean fclean re

