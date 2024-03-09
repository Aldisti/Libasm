
#include <stdio.h>
#include <string.h>
#include <unistd.h>

extern size_t	ft_strlen(char *);

void	test(char *str)
{
	printf("[%s] -> [%ld] == %ld\n", str, strlen(str), ft_strlen(str));
}

int	main(void)
{
	test("");
	test("a");
	test("abcdefghijklmnopqrstuvwxyz");
	return (0);
}

