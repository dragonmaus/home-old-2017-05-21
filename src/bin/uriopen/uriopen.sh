#!/bin/sh -e

die() {
  local l r
  r=$1
  l=$2
  shift 2
  echo uriopen: "$l": "$*" 1>&2
  exit $r
}

usage='uriopen [-a application | -b bundle-id] [-s seconds] uri…'

a=
b=
s=0
while getopts a:b:s: opt; do
  case $opt in
  a|b)
    a=$opt
    b=$OPTARG
    open() {
      command open -$a "$b" ${1+"$@"}
    }
    ;;
  s)
    s=`printf %g "$OPTARG"`
    ;;
  '?')
    die 100 "$usage"
    ;;
  esac
done
shift `expr '(' $OPTIND - 1 ')'`

test $# -gt 0 || die 100 "$usage"

case $a:$b in
a:TorBrowser|b:'org.mozilla.tor browser')
  open -g
  if test ${s%.*} -lt 6; then
    sleep `expr 6 - ${s%.*}`
  fi
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
  i=`expr '(' $i + 1 ')'`
done
