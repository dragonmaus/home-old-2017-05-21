#include <unistd.h>
#include <errno.h>

static unsigned int strlen(char const *s)
{
  register char const *t;

  t = s;
  for (;;) {
    if (!*t) return t - s; ++t;
    if (!*t) return t - s; ++t;
    if (!*t) return t - s; ++t;
    if (!*t) return t - s; ++t;
  }
}

static void die(int e,char const *s)
{
  write(2,s,strlen(s));
  write(2,"\n",1);
  _exit(e);
}

static int atoi(register char const *s)
{
  int sign = 1;
  int c;
  int result = 0;

  if (*s == '-') {
    sign = -1;
    ++s;
  }
  for (;;) {
    c = *s++ - '0';
    if (c < 0 || c > 9) break;
    result = result * 10 + c;
  }
  return sign * result;
}

int main(int argc,char **argv)
{
  (void) argc;
  if (!*++argv) die(100,"isatty: usage: isatty fd");
  if (!isatty(atoi(*argv))) {
    if (errno != ENOTTY) die(111,"isatty: fatal: Bad file descriptor");
    _exit(1);
  }
  _exit(0);
}
