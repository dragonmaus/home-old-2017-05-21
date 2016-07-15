#include "error.h"
#include "scan.h"
#include "strerr.h"
#include <unistd.h>

#define FATAL "isatty: fatal: "

int main(int argc, char **argv)
{
  long i;

  (void) argc;
  if (!*++argv) strerr_die1x(100, "isatty: usage: isatty fd");
  if (!scan_long(*argv, &i)) {
    errno = error_inval;
    strerr_die3sys(111, FATAL, *argv, ": ");
  }
  if (!isatty(i)) {
    if (errno != error_notty) strerr_die3sys(111, FATAL, *argv, ": ");
    _exit(1);
  }
  _exit(0);
}
