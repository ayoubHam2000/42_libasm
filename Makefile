NAME = libasm.a

OBJ_DIR = _OUT/

SRC = ft_strcpy.s \
	ft_strlen.s \
	ft_strcmp.s \
	ft_write.s \
	ft_read.s \
	ft_strdup.s \

B_SRC = ft_list_size_bonus.s \
	ft_list_push_front_bonus.s \
	ft_create_elem_bonus.s \
	ft_list_sort_bonus.s \
	ft_list_remove_if_bonus.s \
	ft_atoi_base_bonus.s \


OBJ = $(addprefix $(OBJ_DIR), $(SRC:.s=.o))
B_OBJ = $(addprefix $(OBJ_DIR), $(B_SRC:.s=.o))

all: $(NAME)

bonus: $(OBJ) $(B_OBJ)
	ar rc $(NAME) $^

test: exec.out

exec.out: $(NAME) ./test/main.c ./test/ft_atoi_base.c
	gcc -c ./test/main.c -o $(OBJ_DIR)/main.o
	gcc -c ./test/ft_atoi_base.c -o $(OBJ_DIR)/ft_atoi_base.o
	gcc $(OBJ_DIR)/main.o $(OBJ_DIR)/ft_atoi_base.o $(NAME) -o exec.out

$(NAME): $(OBJ)
	ar rc $(NAME) $^

$(OBJ) : $(OBJ_DIR)%.o : %.s
	mkdir -p $(dir $@)
	nasm -f elf64 $< -o $@

$(B_OBJ) : $(OBJ_DIR)%.o : %.s
	mkdir -p $(dir $@)
	nasm -f elf64 $< -o $@


clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -rf $(NAME)
	rm -rf exec.out

re: fclean all

