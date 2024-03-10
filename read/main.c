
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern size_t	ft_read(int , void *, size_t);

void	test(const char *path)
{
	int		fd;
	int		size = 100;
	char	buf[size];
	int		ret;

	bzero(buf, size);
	fd = open(path, O_RDONLY);
	ret = read(fd, buf, size);
	close(fd);
	printf("%s\n%d-------------------------\n", buf, ret);
	bzero(buf, size);
	fd = open(path, O_RDONLY);
	ret = ft_read(fd, buf, size);
	close(fd);
	printf("%s\n%d-------------------------\n", buf, ret);
}

int	main(void)
{
	test("ft_read.asm");
	return (0);
}

