
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern size_t	ft_read(int , void *, size_t);

void	test(const char *path)
{
	int		fd;
	int		size = 10;
	char	buf[size];
	int		ret;

	bzero(buf, size);
	fd = open(path, O_RDONLY);
	ret = read(fd, buf, size);
	close(fd);
	printf("%s\n---------\t%d\t-----------\n", buf, ret);

	bzero(buf, size);
	fd = open(path, O_RDONLY);
	ret = ft_read(fd, buf, size);
	close(fd);
	printf("%s\n---------\t%d\t-----------\n", buf, ret);
}

void	test_errno(const char *path)
{
	int	fd;
	int	ret;
	char	buf[32];

	fd = -1;
	ret = 0;
	errno = 0;
	ret = read(fd, buf, 10);
	printf("ret: %d  errno: %d | %s\n", ret, errno, strerror(errno));

	fd = -1;
	ret = 0;
	errno = 0;
	ret = ft_read(fd, buf, 10);
	printf("ret: %d  errno: %d | %s\n", ret, errno, strerror(errno));


	fd = open("tmp.out", O_WRONLY);
	ret = 0;
	errno = 0;
	ret = read(fd, buf, 10);
	printf("ret: %d  errno: %d | %s\n", ret, errno, strerror(errno));
	close(fd);

	fd = open("tmp.out", O_WRONLY);
	ret = 0;
	errno = 0;
	ret = ft_read(fd, buf, 10);
	printf("ret: %d  errno: %d | %s\n", ret, errno, strerror(errno));
	close(fd);
}

int	main(void)
{
	test("ft_read.asm");
	test_errno("file.not_found");
	return (0);
}

