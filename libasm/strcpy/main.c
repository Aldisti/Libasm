
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern char	*ft_strcpy(char *dst, char *src);

int	main(void)
{
	char	*dst = malloc(32);
	char	src[] = "ciao come stai";
	char	*ret;

	ret = strcpy(dst, src);
	printf("%s - %p %p %p\n", ret, ret, dst, src);
	ret = ft_strcpy(dst, src);
	printf("%s - %p %p %p\n", ret, ret, dst, src);
	free(dst);
	return (0);
}

