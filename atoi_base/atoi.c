
#include <stdio.h>

#define TEST(num, base) printf("%-20s=> %d\n", num, ft_atoi_base(num, base));

extern int	ft_isspace(char c);
extern int	ft_strlen(const char *str);
extern int	ft_in(const char c, const char *str);
extern int	ft_numlen(const char *num, const char *base);
extern int	ft_pow(int n, int e);
extern int	ft_check_base(const char *base);
extern int	ft_index(char c, const char *base);
extern int	ft_atoi_base(const char *str, const char *base);

int	main(void)
{
	const char	base10[] = "0123456789";
	const char	base2[] = "01";
	const char	base2a[] = "?h";
	const char	base3[] = "012";
	const char	base3a[] = "*&/";

	printf("\t----- %s -----\n", base10);
	TEST("123", base10)
	TEST("+-+--+123", base10)
	TEST("---123abc", base10)
	TEST("", base10)
	TEST("abc", base10)
	TEST("--abc", base10)
	TEST("--abc123", base10)
	TEST("-- 123", base10)
	TEST("    123", base10)
	TEST(" - - - 123", base10)
	TEST("    -123", base10)
	TEST("    -abc123", base10)
	TEST("  abc  123", base10)
	TEST(" ---+--+1234ab567", base10)
	TEST("00000", base10)
	TEST("1", base10)
	TEST("10", base10)

	printf("\t----- %s -----\n", base2);
	TEST("-01010110", base2)
	TEST("11111111", base2)
	TEST("00000000", base2)
	TEST("-10101010", base2)
	TEST("-01010101", base2)
	TEST("00000001", base2)
	TEST("00000011", base2)

	printf("\t----- %s -----\n", base2a);
	TEST("-?h?h?hh?", base2a)
	TEST("hhhhhhhh", base2a)
	TEST("????????", base2a)
	TEST("-h?h?h?h?", base2a)
	TEST("-?h?h?h?h", base2a)
	TEST("???????h", base2a)
	TEST("??????hh", base2a)

	// 012
	printf("\t----- %s -----\n", base3);
	TEST("102", base3)
	TEST("221102", base3)

	// *&/
	printf("\t----- %s -----\n", base3a);
	TEST("&*/", base3a)
	TEST("//&&*/", base3a)
}

