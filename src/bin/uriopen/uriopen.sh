#!/bin/sh -e

. $HOME/lib/sh/stdlib.sh

usage() (die 100 usage 'uriopen [-a application | -b bundle-id] [-s seconds] uri...')

a= b= s=0
while getopts a:b:s: opt; do
  case $opt in
  a|b)
    a=$opt
    b=$OPTARG
    open() (exec open -$a "$b" ${1+"$@"})
    ;;
  s) s=`printf %g "$OPTARG"`;;
  *) usage;;
  esac
done
shift `expr $OPTIND - 1`

test $# -gt 0 || usage

case $a:$b in
a:TorBrowser|b:'org.mozilla.tor browser')
  open -g
  test ${s%.*} -lt 6 && sleep `expr 6 - ${s%.*}`
  ;;
esac

if test x$s = x0; then
  open -g ${1+"$@"}
  exit $?
fi

i=1
for uri do
  sleep $s
  printf '[%*d/%d] %s\n' ${##} $i $# "$uri"
  open -g "$uri"
  i=`expr $i + 1`
done
