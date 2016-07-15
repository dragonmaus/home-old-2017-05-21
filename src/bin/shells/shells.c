#include "buffer.h"
#include <unistd.h>

int main(void)
{
  char *s;

  while((s = getusershell())) {
    buffer_puts(buffer_1small,s);
    buffer_puts(buffer_1small,"\n");
  }
  buffer_flush(buffer_1small);
  endusershell();
  _exit(0);
}
