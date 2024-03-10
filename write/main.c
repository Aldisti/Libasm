
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern size_t	ft_write(int , void *, size_t);

void	test(int fd, char *str)
{
	write(fd, "|", 1);
	write(fd, str, strlen(str));
	write(fd, "|", 1);
	ft_write(fd, str, strlen(str));
	write(fd, "|\n", 2);
}

int	main(void)
{
	test(1, "");
	test(1, "ciao");
	test(1, "ciao caro come stai?");
	return (0);
}

