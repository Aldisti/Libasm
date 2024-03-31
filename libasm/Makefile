# this is to test read

NAME	= libasm.a
BNAME	= libasm_bonus.a

###################################
### SOURCE & OBJECT DIRECTORIES ###
###################################

SRCDIR	= src
OBJDIR	= obj

BSRCDIR	= src_bonus
BOBJDIR	= obj_bonus

#############################
### SOURCE & OBJECT FILES ###
#############################

MAIN	= $(SRCDIR)/main.c
BMAIN	= $(BSRCDIR)/main.c

SRCS	= $(wildcard $(SRCDIR)/*.s)
OBJS	= $(subst $(SRCDIR), $(OBJDIR), $(SRCS:%.s=%.o))

BSRCS	= $(wildcard $(BSRCDIR)/*.s)
BOBJS	= $(subst $(BSRCDIR), $(BOBJDIR), $(BSRCS:%.s=%.o))

############################
### COMPILERS & ARCHIVES ###
############################

SC		= nasm
SFLAGS	= -f elf64

CC		= gcc
CFLAGS	= -Wall -Wextra -Werror

AR		= ar rcs

#####################
### HELP COMMANDS ###
#####################

RM		= rm -f
RMDIR	= rm -rf

#############
### RULES ###
#############

$(NAME): $(OBJS)
	@$(AR) $(NAME) $(OBJS)
	@$(CC) $(CFLAGS) $(MAIN) $(NAME)

all: $(NAME)

bonus: $(BOBJS)
	$(AR) $(BNAME) $(BOBJS)
	$(CC) $(CFLAGS) $(BMAIN) $(BNAME)

$(OBJDIR):
	@mkdir -p $@

$(BOBJDIR):
	@mkdir -p $@

$(OBJDIR)/%.o : $(SRCDIR)/%.s | $(OBJDIR)
	@$(SC) $(SFLAGS) $< -o $@

$(BOBJDIR)/%.o : $(BSRCDIR)/%.s | $(BOBJDIR)
	$(SC) $(SFLAGS) $< -o $@

clean:
	@$(RM) $(OBJS)

fclean: clean
	@$(RM) $(NAME) $(BNAME) a.out
	@$(RMDIR) $(OBJDIR) $(BOBJDIR)

re: fclean all

.PHONY: all bonus clean fclean re

