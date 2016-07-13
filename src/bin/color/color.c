#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define SIZE(x) (sizeof(x) / sizeof(*(x)))
#define ISSET(x, mode) (((x) & (mode)) == (mode))

enum {
  C_DIR,
  C_LNK,
  C_SOCK,
  C_FIFO,
  C_EXEC,
  C_BLK,
  C_CHR,
  C_SUID,
  C_SGID,
  C_WSDIR,
  C_WDIR,
  C_NUMCOLORS
};

static const char colors[C_NUMCOLORS][6] = {
  "34",
  "35",
  "32",
  "33",
  "31",
  "34;46",
  "34;43",
  "30;41",
  "30;46",
  "30;42",
  "30;43"
};

static int colortype(mode_t mode)
{
  switch (mode & S_IFMT) {
  case S_IFDIR:
    if (mode & S_IWOTH) {
      if (mode & S_ISTXT) return C_WSDIR;
      return C_WDIR;
    }
    return C_DIR;
  case S_IFLNK:
    return C_LNK;
  case S_IFSOCK:
    return C_SOCK;
  case S_IFIFO:
    return C_FIFO;
  case S_IFBLK:
    return C_BLK;
  case S_IFCHR:
    return C_CHR;
  default:
    break;
  }
  if (mode & (S_IXUSR | S_IXGRP | S_IXOTH)) {
    if (mode & S_ISUID) return C_SUID;
    if (mode & S_ISGID) return C_SGID;
    return C_EXEC;
  }
  return -1;
}

int main(void)
{
  char *pos;
  char line[4096];
  struct stat st;
  int x;

  while (fgets(line, sizeof(line), stdin) != NULL) {
    if ((pos = strrchr(line, '\n')) != NULL) *pos = '\0';
    if (lstat(line, &st) < 0) {
      printf("%s\n", line);
      continue;
    }
    if ((x = colortype(st.st_mode)) == -1) {
      printf("%s\n", line);
      continue;
    }
    printf("\e[%sm%s\e[m\n", colors[x], line);
  }
  fflush(stdout);
  _exit(0);
}
