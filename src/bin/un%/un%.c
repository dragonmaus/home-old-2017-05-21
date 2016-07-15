#include <unistd.h>

#define SIZE 4096

static int dehex(char c)
{
  if (c >= '0' && c <= '9') return c - '0' + 0x0;
  if (c >= 'A' && c <= 'F') return c - 'A' + 0xA;
  if (c >= 'a' && c <= 'f') return c - 'a' + 0xa;
  return -1;
}

static void die(void)
{
  if (write(2, "error\n", 6) == -1) _exit(2);
  _exit(1);
}

int main(void)
{
  char buf[SIZE];
  int i, j, k, len;

  while ((len = read(0, buf, SIZE)) > 0) {
    for (i = j = 0; i < len; ++i, ++j) {
      if (buf[i] == '%') {
        if ((k = dehex(buf[++i])) == -1) die();
        buf[j] = (char)(k * 0x10);
        if ((k = dehex(buf[++i])) == -1) die();
        buf[j] += (char)k;
      } else if (i != j) buf[j] = buf[i];
    }
    if (write(1, buf, j) == -1) die();
  }
  if (len == -1) die();
  _exit(0);
}
