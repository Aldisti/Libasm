
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
extern t_list	*ft_list_last(t_list *);
extern void		ft_list_push_back(t_list **, void *);
extern t_list	*ft_list_push_strs(int size, char **);
extern void		ft_list_clear(t_list *, void (*)(void *));
extern t_list	*ft_list_at(t_list *, unsigned int);
extern void		ft_list_reverse(t_list **);
extern void		ft_list_foreach(t_list *, void (*)(void *));
extern void		ft_list_foreach_if(t_list *, void (*)(void *), void *, int (*)());
extern t_list	*ft_list_find(t_list *, void *, int (*)());
extern void		ft_list_remove_if(t_list **, void *, int (*)(), void (*)(void *));
extern void		ft_list_merge(t_list **, t_list *);
extern t_list	*ft_list_min(t_list *, int (*)());
extern void		ft_list_pop(t_list **, t_list *);
extern void		ft_list_sort(t_list **, int (*)());

extern void		print_list(t_list *);

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

void	print_list(t_list *head)
{
	t_list	*node;
	int		tmp;

	node = head;
	while (node)
	{
		printf("|%d", *((int *)node->data));
		node = node->next;
	}
	printf("|\n");
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

void	test_list_last(void)
{
	t_list	*head = 0;
	t_list	*last = 0;
	t_list	*tmp = 0;
	int		size = 3;

	printf("--- ft_list_last ---\n");
	// TEST 1
	head = 0;
	last = ft_list_last(head);
	TEST(!last)
	// TEST 2
	head = create_list(size, 0);
	last = ft_list_last(head);
	tmp = head;
	while (tmp->next)
		tmp = tmp->next;
	TEST(tmp == last)
	delete_list(head);
}

void	test_list_push_back(void)
{
	t_list	*head = 0;
	t_list	*last = 0;
	int		size = 4;

	printf("--- ft_list_push_back ---\n");
	head = create_list(size - 1, 0);
	ft_list_push_back(&head, &size);
	TEST(ft_list_size(head) == size)
	TEST(*((int *)ft_list_last(head)->data) == size)
	delete_list(head);
	head = 0;
	ft_list_push_back(&head, &size);
	TEST(ft_list_size(head) == 1)
	TEST(*((int *)head->data) == size)
	delete_list(head);
}

void	test_list_push_strs(void)
{
	char	*strs[5];
	t_list	*head = 0;
	t_list	*node = 0;

	strs[0] = "ciao";
	strs[1] = "come";
	strs[2] = "stai";
	strs[3] = "?";
	strs[4] = 0;

	printf("--- ft_list_push_strs ---\n");
	// TEST 1-4
	head = ft_list_push_strs(5, strs);
	node = head;
	for (int i = 0; node; i++, node=node->next)
		TEST((char *)node->data == strs[i])
	delete_list(head);
}

/*
	To be sure this works check with
	valgrind if this function has leaks
*/
void	test_list_clear(void)
{
	t_list	*head;

	printf("--- ft_list_clear ---\n");
	head = create_list(5, 0);
	ft_list_clear(head, free);
	TEST(42)
}

void	test_list_at(void)
{
	t_list	*head = 0;
	t_list	*node = 0;
	t_list	*tmp = 0;
	int		index = 5;

	printf("--- ft_list_at ---\n");
	head = create_list(7, 0);
	node = head;
	// TEST 1
	tmp = ft_list_at(head, 10);
	TEST(!tmp)
	// TEST 2
	tmp = ft_list_at(head, index);
	while (index-- > 0)
		node = node->next;
	TEST(node == tmp)
	delete_list(head);
}

void	test_list_reverse(void)
{
	int	arr[] = {1, 2, 3, 4, 5};
	int	size = (int)sizeof(arr) / sizeof(int);
	t_list	*head = 0;

	printf("--- ft_list_reverse ---\n");
	head = create_list(size, 0);
	t_list	*node = head;
	for (int i = 0; i < size; i++, node=node->next)
		node->data = &arr[i];
	ft_list_reverse(&head);
	node = head;
	for (int i = size - 1; node; node=node->next, i--)
		TEST(node->data == &arr[i])
	delete_list(head);
}

void	_add(void *data)
{
	int	*n;

	n = (int *)data;
	(*n)++;
}

void	test_list_foreach(void)
{
	int	arr[] = {1, 2, 3, 4, 5};
	int	size = (int)(sizeof(arr) / sizeof(int));
	t_list	*head = 0;

	printf("--- ft_list_foreach ---\n");
	head = create_list(size, 0);
	{
		t_list	*node = head;
		for (int i = 0; i < size; i++, node=node->next)
			node->data = &arr[i];
	}
	ft_list_foreach(head, _add);
	{
		t_list	*node = head;
		for (int i = 0; node; node=node->next, i++)
			TEST(*((int *)node->data) == i + 2)
	}
	delete_list(head);
}

int	_cmp(void *data, void *data_ref)
{
	int	*a = 0;
	int	*b = 0;

	a = (int *)data;
	b = (int *)data_ref;
	return (*a % *b == 1);
}

void	test_list_foreach_if(void)
{
	int		arr[] = {1, 2, 3, 5, 7};
	int		size = (int)(sizeof(arr) / sizeof(int));
	t_list	*head = 0;
	t_list	*node = 0;
	int		ref = 2;

	printf("--- ft_list_foreach_if ---\n");
	head = create_list(size, 0);
	node = head;
	for (int i = 0; i < size; i++, node=node->next)
		node->data = &arr[i];
	ft_list_foreach_if(head, _add, &ref, _cmp);
	// TEST 1-5
	node = head;
	for (int i = 0; node; node=node->next, i++)
		TEST(*((int *)node->data) % 2 == 0)
	delete_list(head);
}

int	_equal(void *data, void *data_ref)
{
	int	a = *((int *)data);
	int	b = *((int *)data_ref);

//	printf("%d != %d -> %d\n", a, b, a != b);
	return (a != b);
}

void	test_list_find(void)
{
	int		arr[] = {1, 2, 3, 4, 7};
	int		size = (int)(sizeof(arr) / sizeof(int));
	t_list	*head;
	t_list	*node;

	printf("--- ft_list_find ---\n");
	head = create_list(size, 0);
	node = head;
	for (int i = 0; node && i < size; i++, node=node->next)
		node->data = &arr[i];
	// TEST 1
	node = ft_list_find(head, &arr[0], _equal);
	TEST(node && node->data == arr + 0 && *((int *)node->data) == arr[0])
	// TEST 2
	node = ft_list_find(head, &size, _equal);
	TEST(!node)
	// TEST 3
	node = ft_list_find(head, &arr[2], _equal);
	TEST(node && node->data == arr + 2 && *((int *)node->data) == arr[2])
	// TEST 4
	node = ft_list_find(head, &arr[4], _equal);
	TEST(node && node->data == arr + 4 && *((int *)node->data) == arr[4])
	delete_list(head);
}

void	_free_fct(void *data)
{
	free(data);
	data = 0;
}

void	test_list_remove_if(void)
{
	t_list	*head;
	t_list	*node;
	int		n;

	printf("--- ft_list_remove_if ---\n");
	head = create_list(10, 0);
	node = head;
	for (int i = 0; node; i++, node=node->next)
	{
		node->data = malloc(sizeof(int));
		*((int *)node->data) = i % 2;
	}
//	print_list(head);
	// TEST 1
	n = 0;
	ft_list_remove_if(&head, &n, _equal, _free_fct);
	TEST(ft_list_size(head) == 5)
//	print_list(head);
	// TEST 2
	n = 2;
	ft_list_remove_if(&head, &n, _equal, _free_fct);
	TEST(ft_list_size(head) == 5)
//	print_list(head);
	// TEST 2
	n = 1;
	ft_list_remove_if(&head, &n, _equal, _free_fct);
	TEST(!head)
//	print_list(head);
	for (node=head; node; node=node->next)
		free(node->data);
	delete_list(head);
}

void	test_list_merge(void)
{
	t_list	*head = 0;
	t_list	*head_pend = 0;
	t_list	*node = 0;
	int		ret = 0;

	printf("--- ft_list_merge ---\n");
	// TEST 1
	head_pend = create_list(5, 0);
	ft_list_merge(&head, head_pend);
	ret = ft_list_size(head);
	TEST(head && ret == 5)
	// TEST 2
	ft_list_merge(&head, create_list(10, 0));
	ret = ft_list_size(head);
	TEST(head && ret == 15)
	delete_list(head);
}

int	_diff(int *a, int *b)
{
//	printf("%p - %p\n", a, b);
//	printf("%d - %d = %d\n", *a, *b, *a - *b);
	return (*a - *b);
}

void	test_list_min(void)
{
	int		arr[] = {1, 2, 3, 4, 5};
	t_list	*head = 0;
	t_list	*node = 0;

	printf("--- ft_list_min ---\n");
	// TEST 1
	node = ft_list_min(head, _diff);
	TEST(!node)
	ft_list_push_back(&head, arr + 4);
	// TEST 2
	ft_list_push_back(&head, arr + 3);
	node = ft_list_min(head, _diff);
	TEST(node && *((int *)node->data) == 4)
	// TEST 3
	ft_list_push_back(&head, arr + 1);
	node = ft_list_min(head, _diff);
	TEST(node && *((int *)node->data) == 2)
	// TEST 4
	ft_list_push_back(&head, arr + 2);
	node = ft_list_min(head, _diff);
	TEST(node && *((int *)node->data) == 2)
	// TEST 5
	ft_list_push_back(&head, arr + 0);
	node = ft_list_min(head, _diff);
	TEST(node && *((int *)node->data) == 1)
	delete_list(head);
}

void	test_list_pop(void)
{
	t_list	*head = 0;
	t_list	*node = 0;

	printf("--- ft_list_pop ---\n");
	head = create_list(5, 0);
	// TEST 1
	node = head;
	ft_list_pop(&head, node);
	for (t_list *i = head; i; i = i->next)
		TEST(i != node)
	free(node);
	// TEST 2
	node = head->next;
	ft_list_pop(&head, node);
	for (t_list *i = head; i; i = i->next)
		TEST(i != node)
	free(node);
	delete_list(head);
}

int	is_sorted(t_list *head)
{
	for (; head && head->next; head = head->next)
		if (*((int *)head->data) > *((int *)head->next->data))
			return (0);
	return (1);
}

void	test_list_sort(void)
{
	int		arr[] = {7, 2, 5, 4, 2};
	int		size = (int)(sizeof(arr) / sizeof(int));
	t_list	*head = 0;
	t_list	*node = 0;

	printf("--- ft_list_sort ---\n");
	head = create_list(size, 0);
	node = head;
	for (int i = 0; node && i < size; i++, node=node->next)
		node->data = &arr[i];
	// TEST 1
	ft_list_sort(&node, _diff);
	TEST(is_sorted(node))
	// TEST 2
	ft_list_sort(&head, _diff);
	TEST(is_sorted(head))
	// TEST 3
	ft_list_push_back(&head, arr+4);
	ft_list_sort(&head, _diff);
	TEST(is_sorted(head))
	delete_list(head);
}

int	main(void)
{
	test_list_size();
	test_create_elem();
	test_list_push_front();
	test_list_last();
	test_list_push_back();
	test_list_push_strs();
	test_list_clear();
	test_list_at();
	test_list_reverse();
	test_list_foreach();
	test_list_foreach_if();
	test_list_find();
	test_list_remove_if();
	test_list_merge();
	test_list_min();
	test_list_pop();
	test_list_sort();
	return (0);
}

