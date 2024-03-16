
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
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

void	test_errno(void)
{
	int		fd;
	int		ret;
	int		size;
	char	buf[] = "some buffer";

	fd = -1;
	ret = 0;
	size = strlen(buf);
	ret = write(fd, buf, size);
	printf("| ret: %d errno: %d | %s\n", ret, errno, strerror(errno));

	fd = -1;
	ret = 0;
	size = strlen(buf);
	ret = ft_write(fd, buf, size);
	printf("| ret: %d errno: %d | %s\n", ret, errno, strerror(errno));


	fd = open("a.out", O_RDONLY);
	ret = 0;
	size = strlen(buf);
	ret = write(fd, buf, size);
	printf("| ret: %d errno: %d | %s\n", ret, errno, strerror(errno));

	fd = open("a.out", O_RDONLY);
	ret = 0;
	size = strlen(buf);
	ret = ft_write(fd, buf, size);
	printf("| ret: %d errno: %d | %s\n", ret, errno, strerror(errno));
}

int	main(void)
{
	test(1, "");
	test(1, "ciao");
	test(1, "ciao caro come stai?");

	test_errno();
	return (0);
}

