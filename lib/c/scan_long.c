/* Public domain. */

#include "scan.h"

unsigned int scan_long(register const char *s,register long *l)
{
  register int sign = 1;
  register unsigned int pos = 0;
  register unsigned long result = 0;
  register unsigned long c;
  if (*s == '-') {
    sign = -1;
    ++s;
  }
  while ((c = (unsigned long) (unsigned char) (s[pos] - '0')) < 10) {
    result = result * 10 + c;
    ++pos;
  }
  *l = sign * result;
  return pos;
}
