#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

static int nb_char(char *str, char c)
{
  int counter = 0;
  while (*str != 0)
  {
    if (*str == c)
      counter++;
    str++;
  }
  return counter;
}

static int check_base(char *base)
{
  char *p = base;
  while (*p != 0)
  {
    if (*p == '-' || *p == '+' || *p < 33 || *p > 126 || nb_char(base, *p) > 1)
      return -1;
    p++;
  }
  int counter = p - base;
  if (counter < 2) {
    return -1;
  }
  return counter;
}

static char * ft_strchr(char *str, char c)
{
  // c != 0
  while (*str != 0) {
    if (*str == c)
      return str;
    str++;
  }
  return 0;
}

static char *check_number(char *str, char *base)
{
  char *ret = 0;

  while (ft_strchr("\t\v\n\r\f ", *str)) {
    str++;
  }
  while (*str == '+' || *str == '-') {
    str++;
  }
  if (*str == 0)
    return 0;
  ret = str;
  while (*str != 0)
  {
    if (ft_strchr(base, *str) == 0)
      return 0;
    str++;
  }
  return ret;
}

int			atoi_base(char *str, char *base)
{
  int base_len = check_base(base);
  if (base_len == -1)
    return 0;
  int neg = -(nb_char(str, '-') & 1);
  if (neg == 0)
    neg = 1;
  str = check_number(str, base);
  if (!str)
    return 0;
  
  __int64_t nb = 0;
  while (*str)
  {
    int tmp = ft_strchr(base, *str) - base;
    nb = nb * base_len + tmp;
    str++;
  }

  return nb * neg; 
}

// int main()
// {
//   char nb[] = "+22";
//   int l = atoi(nb);
//   int ret = ft_atoi_base(nb, "0123456789");
//   printf("atoi_base=%d atoi=%d\n", ret, l);
//   return 0;
// }