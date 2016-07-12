#if 0
#include "strerr.h"
#include "buffer.h"

#define FATAL "fold: fatal: "

int main(int argc,char **argv)
{
  for (;;) {
    len = buffer_get(buffer_0,buf,BUFFER_INSIZE);
    if (len <= 0) break;
  }
  if (len == -1) strerr_die2sys(111,FATAL,"unable to read input: ")
#else
#include <unistd.h>

#define SIZE 4096

static void die(void)
{
  if (write(2,"error\n",6) == -1) _exit(2);
  _exit(1);
}

int main(void)
{
  char buf[SIZE];
  int e,i,j,len;

  e = 0;
  while ((len = read(0,buf,SIZE)) > 0) {
    for (i = j = 0;i < len;++i,++j) {
      if (e && buf[i] == '\n') {
        e = 0;
        if (++i >= len) break;
      }
      if (buf[i] == '\r') {
        buf[j] = '\n';
        e = 1;
      } else if (i != j) buf[j] = buf[i];
    }
    if (write(1,buf,j) == -1) die();
  }
  if (len == -1) die();
  _exit(0);
}
#endif
