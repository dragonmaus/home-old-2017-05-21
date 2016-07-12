#include "strerr.h"
#include <fcntl.h>
#include <unistd.h>

#define FATAL "fsync: fatal: "

int main(int argc,char **argv)
{
  register int fd;

  (void)argc;
  if (!*++argv) strerr_die1x(100,"fsync: usage: fsync file...");
  for (;;) {
    if ((fd = open(*argv,O_RDONLY | O_NONBLOCK | O_SYMLINK)) == -1)
      strerr_die4sys(111,FATAL,"unable to open ",*argv,": ");
    if (fsync(fd) == -1)
      strerr_die4sys(111,FATAL,"unable to fsync ",*argv,": ");
    if (close(fd) == -1)
      strerr_die4sys(111,FATAL,"unable to close ",*argv,": ");
    if (!*++argv) _exit(0);
  }
}
