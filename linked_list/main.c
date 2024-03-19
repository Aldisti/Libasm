
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#define TEST(statement) (statement) ? write(1, "OK\n", 3) : write(1, "KO\n", 3);

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

extern int		ft_list_size(t_list *);
extern t_list	*ft_create_elem(void *);
extern void		ft_list_push_front(t_list **, void *);

t_list	*create_list(int size, void *data)
{
	t_list	*head = 0;
	t_list	*node = 0;

	if (!size)
		return (0);
	for (int i = 0; i < size; i++)
	{
		if (!node)
		{
			node = (t_list *)malloc(sizeof(t_list));
			node->data = data;
		}
		else
		{
			node->next = (t_list *)malloc(sizeof(t_list));
			node->next->data = data;
		}
		if (!head)
			head = node;
		else
			node = node->next;
		node->next = 0;
	}
	return (head);
}

void	delete_list(t_list *list)
{
	t_list	*tmp = 0;

	tmp = list;
	while (list)
	{
		tmp = list->next;
		free(list);
		list = tmp;
	}
}

void	test_list_size(void)
{
	t_list	*list = 0;
	int		size = 10;
	int		ret = 0;

	printf("--- ft_list_size ---\n");
	// TEST 1
	ret = ft_list_size(list);
	TEST(ret == 0)
	// TEST 2
	list = create_list(size, 0);
	ret = ft_list_size(list);
	TEST(ret == size)
	delete_list(list);
}

void	test_create_elem(void)
{
	t_list	*node = 0;
	int		a = 42;

	printf("--- ft_list_size ---\n");
	// TEST 1
	node = ft_create_elem(0);
	TEST(node && !node->data && !node->next)
	free(node);
	// TEST 2
	node = ft_create_elem(&a);
	TEST(node && *((int *)node->data) == a && !node->next)
	free(node);
}

/*
	This function makes use of ft_list_size so if
	that function is not well implemented, then
	this test will not run correctly.
*/
void	test_list_push_front(void)
{
	t_list	*head = 0;
	int		size = 3;
	int		ret = 0;

	printf("--- ft_list_push_front ---\n");
	// TEST 1
	head = create_list(size, 0);
	ft_list_push_front(&head, &size);
	ret = ft_list_size(head);
	TEST(ret == size + 1)
	delete_list(head);
	// TEST 2
	head = 0;
	ft_list_push_front(&head, &size);
	ret = ft_list_size(head);
	TEST(ret == 1 && *((int *)head->data) == size)
	delete_list(head);
}

int	main(void)
{
	test_list_size();
	test_create_elem();
	test_list_push_front();
	return (0);
}

