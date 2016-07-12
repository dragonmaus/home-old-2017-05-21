#!/bin/sh -e

die() {
  r=$1; l=$2; shift 2
  echo "symdate: $l: $*" 1>&2
  exit $r
}

a=
f=0
while getopts f o; do
  case $o in
  f) f=`expr $f + 1`; a="$a -f";;
  *) die 100 usage 'symdate [-f] symlink...';;
  esac
done
shift `expr -- $OPTIND - 1`

test $# -gt 0 || die 100 usage 'symdate [-f] symlink...'

T=`mktemp -t symdate-$$`
trap -- "rm -f '$T'" EXIT

for l do
  test -h "$l" || die 111 fatal "$link: Not a symbolic link"
  t=`readlink "$l"`
  case $t in
  /*) ;;
  *) d=`dirname "$l"`; t=$d/$t;;
  esac
  if test ! -e "$t"; then
    t=$T
    9 touch -ct 0 "$t"
  elif test -h "$t"; then
    symdate $a "$t"
  fi
  test $f -gt 0 -o `stat -f %m "$t"` -gt `stat -f %m "$l"` && touch -chr "$t" "$l"
done
