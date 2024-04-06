
#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern int      *__errno_location(void);
extern void		*malloc(size_t);
extern int  	ft_strcmp(char *, char *);
extern char 	*ft_strcpy(char *dst, char *src);
extern char 	*ft_strdup(char *);
extern size_t   ft_strlen(char *);
extern size_t   ft_write(int , void *, size_t);
extern size_t   ft_read(int , void *, size_t);

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

void    test_strcmp(char *s1, char *s2)
{
    printf("|%s - %s: %d %d\n", s1, s2, strcmp(s1, s2), ft_strcmp(s1, s2));
    printf("|%s - %s: %d %d\n", s2, s1, strcmp(s2, s1), ft_strcmp(s2, s1));
}

void    ft_test_strcmp(void)
{
    test_strcmp("", "");
    test_strcmp("ciao", "");
    test_strcmp("ciao", "ciao");
    test_strcmp("abc", "cba");
    test_strcmp("a", "abc");
    test_strcmp("ab", "aBc");
}

void    ft_test_strcpy(void)
{
    char    *dst = malloc(32);
    char    src[] = "ciao come stai";
    char    *ret;

    ret = strcpy(dst, src);
    printf("%s - %p %p %p\n", ret, ret, dst, src);
    ret = ft_strcpy(dst, src);
    printf("%s - %p %p %p\n", ret, ret, dst, src);
    free(dst);
}

void    test_strdup(char *str)
{
    char    *dup;

    dup = ft_strdup(str);
    printf("|%s|%s|\n", str, dup);
    if (str && strlen(str))
        printf("last char: %d\n", dup[strlen(str)]);
    free(dup);
}

void    ft_test_strdup(void)
{
    test_strdup("");
    test_strdup("ciao");
}


void    test_strlen(char *str)
{
    printf("[%s] -> [%ld] == %ld\n", str, strlen(str), ft_strlen(str));
}

void    ft_test_strlen(void)
{
    test_strlen("");
    test_strlen("a");
    test_strlen("abcdefghijklmnopqrstuvwxyz");
}

void    test_write(int fd, char *str)
{
    write(fd, str, strlen(str));
    write(fd, "|", 1);
    ft_write(fd, str, strlen(str));
    write(fd, "|\n", 2);
}

void    test_errno_write(void)
{
    int     fd;
    int     ret;
    int     size;
    char    buf[] = "some buffer";

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

void    ft_test_write(void)
{
    test_write(1, "");
    test_write(1, "ciao");
    test_write(1, "ciao caro come stai?");
    test_errno_write();
}

void    test_read(const char *path)
{
    int     fd;
    int     size = 23;
    char    buf[size];
    int     ret;

    bzero(buf, size);
    fd = open(path, O_RDONLY);
    ret = read(fd, buf, size - 1);
	buf[size - 1] = 0;
    close(fd);
    printf("%s| ret: %d\n", buf, ret);

    bzero(buf, size);
    fd = open(path, O_RDONLY);
    ret = ft_read(fd, buf, size - 1);
	buf[size - 1] = 0;
    close(fd);
    printf("%s| ret: %d\n", buf, ret);
}

void    test_errno_read(const char *path)
{
    int fd;
    int ret;
    char    buf[32];

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


    fd = open(path, O_WRONLY);
    ret = 0;
    errno = 0;
    ret = read(fd, buf, 10);
    printf("ret: %d  errno: %d | %s\n", ret, errno, strerror(errno));
    close(fd);

    fd = open(path, O_WRONLY);
    ret = 0;
    errno = 0;
    ret = ft_read(fd, buf, 10);
    printf("ret: %d  errno: %d | %s\n", ret, errno, strerror(errno));
    close(fd);
}

void    ft_test_read(void)
{
    test_read("Makefile");
    test_errno_read("file.not_found");
}

int	main(void)
{
	printf("\n#-#-#-#-#-#-#-#-#-# strlen #-#-#-#-#-#-#-#-#-#\n\n");
	ft_test_strlen();
	printf("\n#-#-#-#-#-#-#-#-#-# strcpy #-#-#-#-#-#-#-#-#-#\n\n");
	ft_test_strcpy();
	printf("\n#-#-#-#-#-#-#-#-#-# strcmp #-#-#-#-#-#-#-#-#-#\n\n");
	ft_test_strcmp();
	printf("\n#-#-#-#-#-#-#-#-#-# write #-#-#-#-#-#-#-#-#-#\n\n");
	ft_test_write();
	printf("\n#-#-#-#-#-#-#-#-#-# read #-#-#-#-#-#-#-#-#-#\n\n");
	ft_test_read();
	printf("\n#-#-#-#-#-#-#-#-#-# strdup #-#-#-#-#-#-#-#-#-#\n\n");
	ft_test_strdup();
}

