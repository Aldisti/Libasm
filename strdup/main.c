
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern char	*ft_strdup(char *);

void	test(char *str)
{
	char	*dup;

	dup = ft_strdup(str);
	printf("|%s|%s|\n", str, dup);
	if (str && strlen(str))
		printf("last char: %d\n", dup[strlen(str)]);
	free(dup);
}

int	main(void)
{
	test("");
	test("ciao");
	return (0);
}

