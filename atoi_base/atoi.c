
#include <stdio.h>

#define TEST_ATOI(num, base) printf("%-20s=> %d\n", num, ft_atoi_base(num, base));

extern int	ft_atoi_base(const char *str, const char *base);

int	main(void)
{
	const char	base10[] = "0123456789";
	const char	base2[] = "01";
	const char	base2a[] = "?h";
	const char	base3[] = "012";
	const char	base3a[] = "*&/";

	printf("\t----- %s -----\n", base10);
	TEST_ATOI("123", base10)
	TEST_ATOI("+-+--+123", base10)
	TEST_ATOI("---123abc", base10)
	TEST_ATOI("", base10)
	TEST_ATOI("abc", base10)
	TEST_ATOI("--abc", base10)
	TEST_ATOI("--abc123", base10)
	TEST_ATOI("-- 123", base10)
	TEST_ATOI("    123", base10)
	TEST_ATOI(" - - - 123", base10)
	TEST_ATOI("    -123", base10)
	TEST_ATOI("    -abc123", base10)
	TEST_ATOI("  abc  123", base10)
	TEST_ATOI(" ---+--+1234ab567", base10)
	TEST_ATOI("00000", base10)
	TEST_ATOI("1", base10)
	TEST_ATOI("10", base10)

	printf("\t----- %s -----\n", base2);
	TEST_ATOI("-01010110", base2)
	TEST_ATOI("11111111", base2)
	TEST_ATOI("00000000", base2)
	TEST_ATOI("-10101010", base2)
	TEST_ATOI("-01010101", base2)
	TEST_ATOI("00000001", base2)
	TEST_ATOI("00000011", base2)

	printf("\t----- %s -----\n", base2a);
	TEST_ATOI("-?h?h?hh?", base2a)
	TEST_ATOI("hhhhhhhh", base2a)
	TEST_ATOI("????????", base2a)
	TEST_ATOI("-h?h?h?h?", base2a)
	TEST_ATOI("-?h?h?h?h", base2a)
	TEST_ATOI("???????h", base2a)
	TEST_ATOI("??????hh", base2a)

	// 012
	printf("\t----- %s -----\n", base3);
	TEST_ATOI("102", base3)
	TEST_ATOI("221102", base3)

	// *&/
	printf("\t----- %s -----\n", base3a);
	TEST_ATOI("&*/", base3a)
	TEST_ATOI("//&&*/", base3a)
}

