#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>

typedef struct	s_list
{
	void						*data;
	struct s_list 	*next;
} t_list;

size_t		ft_strlen(const char *s);
char			*ft_strcpy(char *dst, const char *src);
int				ft_strcmp(const char *s1, const char *s2);
ssize_t		ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t		ft_read(int fildes, void *buf, size_t nbyte);
char			*ft_strdup(const char *s1);

int			ft_atoi_base(char *str, char *base);
int			ft_list_push_front(t_list **begin_list, void *data);
int			ft_list_size(t_list *lst);
void		ft_list_sort(t_list **begin_list, int (*cmp)());
void		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());