#include "libasm.h"

int other_tests()
{
	//ft_strdup
	printf("%s\n", ft_strdup("String to copy"));

	//ft_read
	char buffer[100];
	printf("%ld => '%s'\n", ft_read(1, buffer, 5), buffer);
	printf("errno = %d\n", errno);
	perror("Error:");

	//ft_write
	printf("%ld\n", ft_write(-1, "Nice\n", 5));
	printf("errno = %d\n", errno);
	perror("Error:");
	//strcmp
	printf("%d\n", ft_strcmp("", ""));
	printf("%d\n", strcmp("", ""));
	// ft_strlen
	const char str[] = "Nice Cool";
	size_t str_size = ft_strlen(str);
	printf("%ld\n", str_size);

	// strcpy
	char dest[20];
	char *ret = ft_strcpy(dest, str);
	printf("1.%s\n", dest);
	printf("2.%s\n", ret);
	return 0;
}


// Helper to print the list (assuming data is string)
void print_list(t_list *list)
{
		while (list)
		{
				printf("%s -> ", (char *)list->data);
				list = list->next;
		}
		printf("NULL\n");
}

// Comparison function
int cmp_str(void *a, void *b)
{
		return strcmp((char *)a, (char *)b);
}

int test_list(void)
{
		t_list *my_list = NULL;

		// ===== Test ft_list_push_front & ft_create_elem =====
		ft_list_push_front(&my_list, "date");
		ft_list_push_front(&my_list, "banana");
		ft_list_push_front(&my_list, "apple");
		ft_list_push_front(&my_list, "cherry");

		printf("Initial list:\n");
		print_list(my_list);

		// ===== Test ft_list_size =====
		printf("List size: %d\n\n", ft_list_size(my_list));

		// ===== Test ft_list_sort =====
		ft_list_sort(&my_list, cmp_str);
		printf("Sorted list:\n");
		print_list(my_list);

		// ===== Test ft_list_remove_if =====
		ft_list_remove_if(&my_list, "banana", cmp_str);
		printf("List after removing 'banana':\n");
		print_list(my_list);

		ft_list_remove_if(&my_list, "not_in_list", cmp_str);
		printf("Attempted to remove 'not_in_list':\n");
		print_list(my_list);

		ft_list_remove_if(&my_list, "date", cmp_str);
		printf("Removed 'date':\n");
		print_list(my_list);

		ft_list_remove_if(&my_list, "apple", cmp_str);
		printf("Removed 'apple':\n");
		print_list(my_list);

		ft_list_remove_if(&my_list, "cherry", cmp_str);
		printf("Removed 'cherry':\n");
		print_list(my_list);

		ft_list_remove_if(&my_list, "cherry", cmp_str);
		printf("Attempted to remove 'cherry':\n");
		print_list(my_list);
		return 0;
}










int			atoi_base(char *str, char *base);
# define RESET   "\033[0m"
# define RED     "\033[31m"
# define GREEN   "\033[32m"

int		atoi_base_test(char *str, char *base)
{
	int 	ret1;
	int		ret2;

	ret1 = atoi_base(str, base);
	
	ret2 = ft_atoi_base(str, base);
	if (ret1 == ret2){
		printf("" GREEN "[OK] " RESET "");
		printf("%d == %d\n", ret1, ret2);
	}
	else {
		printf("" RED "[KO] " RESET "");
		printf("%d != %d\n", ret1, ret2);
	}
	return (1);
}



void	test_atoi_base()
{
	printf("%-16s :  \n", "ft_atoi_base.s");
	atoi_base_test("      ++++---2147483647", "0123456789"); //0
	atoi_base_test("2147483647", "0123456789");
	atoi_base_test("", "0123456789");
	atoi_base_test("2147483647", "011");
	atoi_base_test("18f", "0123456789abcdef");//399
	atoi_base_test("18fb52", "0123456789");
	atoi_base_test("18f", "");
	atoi_base_test("101", "1");
	atoi_base_test("45", "");
	atoi_base_test("45", "0");
	atoi_base_test("--2147483647", "0123456789");
	atoi_base_test("--2147483648", "0123456789");
	atoi_base_test("--2147483647", "0123456789-");
	atoi_base_test("-2147483647", "0123456789-");
	atoi_base_test(" \t--\t-2147483647", "0123456789");
	atoi_base_test("  -+\v++-\t--2147483647", "0123456789");
	atoi_base_test("10", "0123456789");
	atoi_base_test("10e", "0123456789");
	atoi_base_test("98", "8923456701");
	atoi_base_test("", "8923456701");
	atoi_base_test("   ", "8923456701");
	atoi_base_test("1", "89234567011");
	atoi_base_test("1", "");
	atoi_base_test("1e", "21e");
	printf("\n\n");
}

int main()
{
	// other_tests();
	// test_list();
	test_atoi_base();
	return 0;
}

