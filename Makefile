SRCS =			ft_strlen.s \
				ft_strcpy.s \
				ft_write.s \
				ft_read.s \
				ft_strcmp.s \
				ft_strdup.s \

SRCS_BONUS =	ft_list_size.s \
				ft_list_push_front.s \
				ft_list_remove_if.s \
				ft_list_sort.s \
				ft_atoi_base.s

NAME = libasm.a
EXEC = ./prog

OBJS = $(SRCS:.s=.o)
OBJS_BONUS = $(SRCS_BONUS:.s=.o)

INC_DIR = includes/
HEADER_PATH = -I $(INC_DIR)

CC = clang
LIB_FLAGS = -L. -lasm
LINUX_64_FLAGS = nasm -f elf64
CFLAGS = -g -Wall -Wextra -Werror

all : $(NAME)

%.o : %.s
	@echo "Compiling assembly files into object format..." $<
	$(LINUX_64_FLAGS) $< -o $@

$(NAME): $(OBJS)
	@echo "Mandatory"
	@echo "Linking process..."
	ar -rcs $(NAME) $(OBJS) 

bonus: $(OBJS) $(OBJS_BONUS)
	@echo "Bonus"
	@echo "Linking process..."
	ar -rcs $(NAME) $(OBJS) $(OBJS_BONUS)

test: $(NAME)
	$(CC) $(CFLAGS) main.c $(HEADER_PATH) $(LIB_FLAGS) -o $(EXEC)

test_bonus: bonus
	$(CC) $(CFLAGS) main_bonus.c $(HEADER_PATH) $(LIB_FLAGS) -o $(EXEC)

clean:
	@echo "Cleaning..."
	rm -f $(OBJS) $(OBJS_BONUS)

fclean: clean
	rm -f $(NAME) $(EXEC)

re: fclean test

re_bonus: fclean test_bonus

.PHONY: all clean fclean re test_bonus
