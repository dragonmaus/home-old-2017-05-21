/* Public domain. */

#include "buffer.h"

int buffer_0small_read(fd,buf,len) int fd; char *buf; int len;
{
  if (buffer_flush(buffer_1small) == -1) return -1;
  return buffer_unixread(fd,buf,len);
}

char buffer_0small_space[256];
static buffer it = BUFFER_INIT(buffer_0small_read,0,buffer_0small_space,sizeof buffer_0small_space);
buffer *buffer_0small = &it;
