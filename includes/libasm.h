#ifndef LIBASM_H
# define LIBASM_H

# include "libasm_utilities.h"

/* Mandatory part */

size_t          ft_strlen(char*);
char*           ft_strcpy(char*, char*);
ssize_t         ft_write(int, const void*, size_t);
ssize_t         ft_read(int, void*, size_t);
int             ft_strcmp(const char* s1, const char* s2);
char*           ft_strdup(const char* s);

#endif
