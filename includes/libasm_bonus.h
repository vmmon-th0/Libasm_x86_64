#ifndef LIBASM_H
# define LIBASM_H

# include "libasm_utilities.h"

/* Mandatory part */

size_t      ft_strlen(char*);
char*       ft_strcpy(char*, char*);
ssize_t     ft_write(int, const void*, size_t);
ssize_t     ft_read(int, void*, size_t);
int         ft_strcmp(const char* s1, const char* s2);
char*       ft_strdup(const char* s);

/* Bonus part */

typedef struct s_list
{
    void    *data;
    struct  s_list *next;
} t_list;

int         ft_list_size(t_list *begin_list);
void        ft_list_sort(t_list **begin_list, int (*cmp)());
int         ft_atoi_base(char *str, char *base);
void        ft_list_push_front(t_list **begin_list, void *data);
void        ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

#endif