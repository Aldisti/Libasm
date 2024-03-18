
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

void	test_errno(int fd)
{
	int		ret;
	int		size;
	char	buf[] = "some buffer";

	size = strlen(buf);

	printf("--------------------\n");
	ret = 0;
	ret = write(fd, buf, size);
	printf("| ret: %d errno: %d | %s\n", ret, errno, strerror(errno));

	ret = 0;
	ret = ft_write(fd, buf, size);
	printf("| ret: %d errno: %d | %s\n", ret, errno, strerror(errno));
	printf("--------------------\n");
}

void	test_errno_max(void)
{
	int		fd;
	int		ret;
	char	*buf;

	buf = malloc(2147483000);
	bzero(buf, 2147483000);
	fd = open("test.out", O_RDWR);
	printf("--------------------\n");
	ret = write(fd, buf, 2147483000);
	printf("| ret: %d errno: %d | %s\n", ret, errno, strerror(errno));
	ret = ft_write(fd, buf, 2147483000);
	printf("| ret: %d errno: %d | %s\n", ret, errno, strerror(errno));
	printf("--------------------\n");

}

int	main(void)
{
	test(1, "");
	test(1, "ciao");
	test(1, "ciao caro come stai?");

	test_errno(-1);
	test_errno(open("test.out", O_RDONLY));
	test_errno(open("test.out", O_NONBLOCK));
	test_errno_max();
	return (0);
}

