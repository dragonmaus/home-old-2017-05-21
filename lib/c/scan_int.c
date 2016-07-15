/* Public domain. */

#include "scan.h"

unsigned int scan_int(register const char *s,register int *l)
{
  register int sign = 1;
  register unsigned int pos = 0;
  register unsigned int result = 0;
  register unsigned int c;
  if (*s == '-') {
    sign = -1;
    ++s;
  }
  while ((c = (unsigned int) (unsigned char) (s[pos] - '0')) < 10) {
    result = result * 10 + c;
    ++pos;
  }
  *l = sign * result;
  return pos;
}
