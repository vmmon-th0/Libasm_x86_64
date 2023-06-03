#include "libasm.h"

void
print_success(void)
{
	write(STDOUT_FILENO, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));
}

void
ft_write_test(void)
{
	printf("..:::write | _ft_write:::..\n\n");

	ssize_t x[2];
	int 	null_fd = open("/dev/null", O_WRONLY);

	if (null_fd == -1)
	{
		printf("open() failed\n");
		return ;
	}

	int original_stdout = dup(STDOUT_FILENO);
	int original_stderr = dup(STDERR_FILENO);

	dup2(null_fd, STDOUT_FILENO);
	dup2(null_fd, STDERR_FILENO);

	x[0] = write(1, STR_INPUT_1, strlen(STR_INPUT_1));
	x[1] = ft_write(1, STR_INPUT_1, strlen(STR_INPUT_1));
	assert(x[0] == x[1]);
	write(original_stdout, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));

	x[0] = write(2, STR_INPUT_2, strlen(STR_INPUT_2));
    x[1] = ft_write(2, STR_INPUT_2, strlen(STR_INPUT_2));
	assert(x[0] == x[1]);
	write(original_stdout, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));

    write(11, STR_INPUT_2, strlen(STR_INPUT_2));
    x[0] = errno;
    ft_write(11, STR_INPUT_2, strlen(STR_INPUT_2));
    x[1] = errno;
	assert(x[0] == x[1]);
	write(original_stdout, SUCCESSFUL_ASSERT, strlen(SUCCESSFUL_ASSERT));

	dup2(original_stdout, STDOUT_FILENO);
	dup2(original_stderr, STDERR_FILENO);

	close(original_stdout);
	close(original_stderr);
	close(null_fd);
	printf("\n\n");
	return ;
}

void
ft_read_test(void)
{
	printf("..:::read | _ft_read:::..\n\n");

	ssize_t x[2];
    char    c;
	int		fd = open("includes/libasm.h", O_RDONLY);
	char 	buffer[BUFFER_SIZE], buffer2[BUFFER_SIZE];

	bzero(buffer, sizeof(buffer));
	bzero(buffer2, sizeof(buffer2));

	if (fd == -1)
	{
		printf("open() failed\n");
		return ;
	}

	x[0] = read(fd, buffer, BUFFER_SIZE);
	close(fd);

	fd = open("includes/libasm.h", O_RDONLY);
    if (fd == -1)
	{
		printf("open() failed\n");
		return ;
	}

	x[1] = ft_read(fd, buffer2, BUFFER_SIZE);
	close(fd);

	assert(!strcmp(buffer, buffer2));
	print_success();

	assert(x[0] == x[1]);
	print_success();
    printf("..:::stdin read:::..\n\n");
    while (read(0, &c, 1) > 0)
    {
            printf("%c\n", c);
    }

    printf("..:::stdin ft_read:::..\n\n");
    while (ft_read(0, &c, 1) > 0)
    {
            printf("%c\n", c);
    }
	printf("\n\n");
	return ;
}

void
ft_strlen_test(void)
{
	printf("..:::strlen | _ft_strlen:::..\n\n");

	size_t x[2];

    x[0] = strlen("");
	x[1] = ft_strlen("");
	assert(x[0] == x[1]);
	print_success();

	x[0] = strlen(STR_INPUT_1);
	x[1] = ft_strlen(STR_INPUT_1);
	assert(x[0] == x[1]);
	print_success();

	printf("\n\n");
	return ;
}

void
ft_strcmp_test(void)
{
	printf("..:::strcmp | _ft_strcmp:::..\n\n");

	size_t x[2];

	x[0] = strcmp(STR_INPUT_1, STR_INPUT_1);
	x[1] = ft_strcmp(STR_INPUT_1, STR_INPUT_1);
	assert(x[0] == x[1]);
	print_success();

	x[0] = strcmp("SomethingInThe", "SomethingOutSide");
	x[1] = ft_strcmp("SomethingInThe", "SomethingOutSide");
	assert(x[0] == x[1]);
	print_success();

	x[0] = strcmp("a", "b");
	x[1] = ft_strcmp("a", "b");
	assert(x[0] == x[1]);
    print_success();

	x[0] = strcmp("", "");
    x[1] = ft_strcmp("", "");
    assert(x[0] == x[1]);
    print_success();

    x[0] = strcmp("", "SOMETHING");
    x[1] = ft_strcmp("", "SOMETHING");
    assert(x[0] == x[1]);
    print_success();

    x[0] = strcmp("SOMETHING", "");
    x[1] = ft_strcmp("SOMETHING", "");
    assert(x[0] == x[1]);
    print_success();

    x[0] = strcmp("addr", "addrr");
    x[1] = ft_strcmp("addr", "addrr");
    assert(x[0] == x[1]);
    print_success();

    printf("\n");
    return ;
}

void
ft_strdup_test(void)
{
	printf("..:::strdup | _ft_strdup:::..\n\n");

	const char* buffer1 = NULL;
	const char* buffer2 = NULL;

	buffer1 = strdup(STR_INPUT_4);
	buffer2 = ft_strdup(STR_INPUT_4);
	assert(!strcmp(buffer1, buffer2));
	print_success();
	free((char*)buffer1);
	free((char*)buffer2);

	buffer1 = strdup("");
	buffer2 = ft_strdup("");
	assert(!strcmp(buffer1, buffer2));
	print_success();
	free((char*)buffer1);
	free((char*)buffer2);

	printf("\n");
	return ;
}

void
ft_strcpy_test(void)
{
	printf("..:::strcpy | _ft_strcpy:::..\n\n");

    char lng_buffer1 [BUFFER_SIZE];
    char lng_buffer2 [BUFFER_SIZE];

	char buffer1 [42];
	char buffer2 [42];

	bzero(buffer1, sizeof(buffer1));
	bzero(buffer2, sizeof(buffer2));

	ft_strcpy(buffer1, STR_INPUT_3);
	strcpy(buffer2, STR_INPUT_3);
	assert(!strcmp(buffer1, buffer2));
	print_success();

	ft_strcpy(buffer1, buffer1 + 3);
	strcpy(buffer2, buffer2 + 3);
	assert(!strcmp(buffer1, buffer2));
    print_success();
	bzero(buffer1, sizeof(buffer1));
    bzero(buffer2, sizeof(buffer2));

    ft_strcpy(lng_buffer1, STR_INPUT_4);
    strcpy(lng_buffer2, STR_INPUT_4);
    assert(!strcmp(lng_buffer1, lng_buffer2));
    print_success();
    bzero(lng_buffer1, sizeof(lng_buffer1));
    bzero(lng_buffer2, sizeof(lng_buffer2));

    ft_strcpy(buffer1, "");
	strcpy(buffer2, "");
	assert(!strcmp(buffer1, buffer2));
    print_success();
	bzero(buffer1, sizeof(buffer1));
    bzero(buffer2, sizeof(buffer2));

	printf("\n");
	return ;
}

int
main(void)
{
	ft_write_test();
	ft_read_test();
	ft_strlen_test();
	ft_strcmp_test();
	ft_strdup_test();
	ft_strcpy_test();
    return 0;
}
