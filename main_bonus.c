#include "libasm_bonus.h"

void
print_success(void)
{
	write(STDOUT_FILENO, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));
}

int
lower(void *d1, void *d2)
{
    return ((long long)d1 > (long long)d2);
}

int
equal(void *d1, void *d2)
{
    return (*(char*)d1 - *(char*)d2);
}

t_list*
create_elem(void* data)
{
    t_list* link = malloc(16);

    link->data = data;
    link->next = NULL;

    return link;
}

void
display_linked_list(t_list* genisis_block)
{
    while (genisis_block)
    {
        printf("%c\n", *(char *)(genisis_block->data));
        genisis_block = genisis_block->next;
    }
    return ;
}

void
free_lst(t_list* genisis_block)
{
    while (genisis_block)
    {
        t_list* next = genisis_block->next;
        free(genisis_block);
        genisis_block = next;
    }
    return ;
}

void
free_func(void* data)
{
    if (data)
    {
        //free(data);
    }
}

void
removee(void *s)
{
	(void)s;
	*(char*)s = 'X';
}

void
ft_list_size_test(void)
{
    t_list x, y, z;

    printf("..::: ft_list_size :::..\n\n");
    x.next = &y;
    y.next = &z;
    z.next = NULL;

    x.data = NULL;
    y.data = NULL;
    z.data = NULL;

    int rtvl = ft_list_size(&x);

    assert(rtvl == 3);
    write(1, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));
    
    rtvl = ft_list_size(NULL);
    assert(rtvl == 0);
    write(1, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));
    printf("\n\n");
}

void
ft_list_sort_test(void)
{
    t_list x, y, z;

    printf("..::: ft_list_sort :::..\n\n");
    x.next = &y;
    y.next = &z;
    z.next = NULL;

    char *s1 = "a";
    char *s2 = "b";
    char *s3 = "c";

    x.data = s2;
    y.data = s1;
    z.data = s3;

    t_list* tmp = &x;

    ft_list_sort(&tmp, &ft_strcmp);

    assert(x.data == s1);
    assert(x.next->data == s2);
    assert(x.next->next->data == s3);
    write(1, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));
    printf("\n\n");
}

void
ft_atoi_base_test(void)
{
    printf("..::: ft_atoi_base :::..\n\n");

    int rtvl = ft_atoi_base("1011", "0123456789");
    assert(rtvl == 1011);
	write(1, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));

    rtvl = ft_atoi_base("5D", "0123456789ABCDEF");
    assert(rtvl == 93);
	write(1, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));

    printf("\n\n");
}

void
ft_list_remove_if_test(void)
{
    t_list* x = NULL;

    printf("..::: ft_list_remove_if :::..\n\n");
 
    ft_list_push_front(&x, (void *)"A");
    ft_list_push_front(&x, (void *)"B");
    ft_list_push_front(&x, (void *)"C");
    ft_list_push_front(&x, (void *)"D");
    
    ft_list_remove_if(&x, (void *)"D", &equal, &free_func);
    assert(ft_list_size(x) == 3);
	write(1, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));

    printf("\n\n");
}

void
ft_list_push_front_test(void)
{
    t_list* x = NULL;

    printf("..::: ft_list_push_front :::..\n\n");

    ft_list_push_front(&x, (void *)"A");
    assert(!strcmp(x->data, (void*)"A"));
    write(1, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));

    ft_list_push_front(&x, (void *)"C");
    assert(!strcmp(x->data, (void*)"C"));
    write(1, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));

    printf("\n\n");
}

int
main(void)
{
    ft_atoi_base_test();
    ft_list_size_test();
    ft_list_sort_test();
    ft_list_remove_if_test();
    ft_list_push_front_test();
    return 0;
}
