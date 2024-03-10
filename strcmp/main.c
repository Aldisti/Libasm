
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern int	ft_strcmp(char *, char *);

void	test(char *s1, char *s2)
{
	printf("|%s - %s: %d %d\n", s1, s2, strcmp(s1, s2), ft_strcmp(s1, s2));
	printf("|%s - %s: %d %d\n", s2, s1, strcmp(s2, s1), ft_strcmp(s2, s1));
}

int	main(void)
{
	test("", "");
	test("ciao", "");
	test("ciao", "ciao");
	test("abc", "cba");
	test("a", "abc");
	test("ab", "aBc");
	return (0);
}

