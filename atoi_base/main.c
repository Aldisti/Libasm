
#include <stdio.h>
#include <unistd.h>
#include <string.h>

//extern int	ft_atoi_base(char *str, char *base);
extern int	ft_strlen(char *);
extern int	ft_in(char, char *);
extern int	ft_chk_db(char *);
extern int	ft_chk_ch(char *);
extern int	ft_chk_base(char *);

int	main(void)
{
	printf("%d - %d - %d\n",
		ft_strlen(""),
		ft_strlen("ciao"),
		ft_strlen("ciao come stai")
	);

	printf("%d - %d - %d - %d\n",
		ft_in('f', "ciao"),
		ft_in('c', "ciao"),
		ft_in('o', "ciao"),
		ft_in('\0', "ciao")
	);

	printf("%d - %d - %d - %d\n",
		ft_chk_db("ciao"),
		ft_chk_db("ccao"),
		ft_chk_db("ciac"),
		ft_chk_db("")
	);
	printf("%d - %d - %d - %d - %d\n",
		ft_chk_ch("ciao"),
		ft_chk_ch("+ciao"),
		ft_chk_ch("ciao-"),
		ft_chk_ch("ci ao"),
		ft_chk_ch("")
	);

	printf("%d - %d - %d - %d - %d\n",
		ft_chk_base(""),
		ft_chk_base("01"),
		ft_chk_base("010"),
		ft_chk_base("-1a"),
		ft_chk_base("0123456789abcdef")
	);
}

