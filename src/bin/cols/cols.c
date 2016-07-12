#include <ctype.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>

#define MAX(a,b) (((a) > (b)) ? (a) : (b))
#define MIN(a,b) (((a) < (b)) ? (a) : (b))

struct word {
  int plen;
  char chars[1];
};

static struct word **words;
static int nwords;

static int printlen(char *str)
{
  int len,clen;
  char *top = str + strlen(str);

  for (len = 0;str < top;str += clen) {
    clen = mblen(str,top - str);
    if (clen == 1 && !isprint(*str)) {
      if (memcmp(str++,"\e[",2) == 0) while (!isalpha(*++str)) ;
      continue;
    }
    len += clen;
  }
  return len;
}

static struct word *mkword(char *str)
{
  int slen = strlen(str);
  struct word *w = malloc(slen + sizeof(*w));

  w->plen = printlen(str);
  memcpy(w->chars,str,slen + 1);
  return w;
}

static int numrows(int ncols)
{
  return (nwords + ncols - 1) / ncols;
}

static void calcwidths(int *max, int ncols)
{
  memset(max,0,ncols * sizeof(int));
  int x,hgt = numrows(ncols);

  for (x = 0;x < nwords;x++) max[x / hgt] = MAX(max[x / hgt],words[x]->plen);
}

static int sum(int *arr, int n)
{
  int s = 0;

  while (n--) s += *arr++;
  return s;
}

static int numcols(int *widths, int termwidth)
{
  int ncols = MIN(nwords,termwidth / 3);

  for (;ncols > 1;ncols--) {
    calcwidths(widths,ncols);
    if (sum(widths,ncols) + 2 * (ncols - 1) <= termwidth) break;
  }
  return ncols;
}

static void fill(int n)
{
  if (n <= 0) return;

  char c[n];

  memset(c,' ',n);
  fwrite(c,1,n,stdout);
}

static void readwords(void)
{
  char *pos,line[LINE_MAX];
  int maxwords = 100;

  words = malloc(maxwords * (sizeof(*words)));
  for (nwords = 0;fgets(line,sizeof(line),stdin);) {
    if ((pos = strrchr(line,'\n')) != NULL) *pos = '\0';
    words[nwords++] = mkword(line);
    if (nwords >= maxwords) {
      maxwords = 3 * maxwords / 2;
      words = realloc(words,maxwords * (sizeof(*words)));
    }
  }
  words = realloc(words,nwords * (sizeof(*words)));
}

static int termwidth(void)
{
  struct winsize win;

  if (ioctl(1,TIOCGWINSZ,&win) < 0) return atoi(getenv("COLUMNS") ? : "3");
  return win.ws_col;
}

int main(void)
{
  readwords();
  if (nwords < 1) return 0;
  if (nwords == 1) {
    fputs(words[0]->chars,stdout);
    fputs("\n",stdout);
    return 0;
  }

  int twidth = termwidth();
  int widths[twidth];
  int ncols = numcols(widths,twidth);
  int nrows = numrows(ncols);
  int x,y;

  for (y = 0;y < nrows;y++) for (x = 0;x < ncols;x++) {
    int word = (x * nrows) + y;
    if (word < nwords) {
      fputs(words[word]->chars,stdout);
      fill(widths[x] - words[word]->plen);
    }
    fputs((x == ncols - 1) ? "\n" : "  ",stdout);
  }
  return 0;
}
