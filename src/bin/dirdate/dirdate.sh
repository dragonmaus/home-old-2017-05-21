#!/bin/sh -e

. "$HOME"/lib/sh/stdlib.sh

usage() (die 100 usage "dirdate [-f] dir...")
walk() (cd "$1"; shift; exec find -x . ! -path . -prune ${1+"$@"})

a= f=0
while getopts f o; do
  case $o in
  f) f=`expr -- $f + 1`; a=$a' -f';;
  *) usage;;
  esac
done
shift `expr -- $OPTIND - 1`

test $# -gt 0 || usage

for dir do
  test -e "$dir" || die 111 fatal "$dir: No such file or directory"
  test -d "$dir" || die 111 fatal "$dir: Not a directory"
  test $f -lt 2 -a `walk "$dir" | wc -l` -eq 0 && continue
  walk "$dir" -type d -print0 | xargs -0 dirdate $a
  walk "$dir" -type l -print0 | xargs -0 symdate $a
  t=`walk "$dir" -print0 | xargs -0 stat -f %m | sort -n | tail -1`
  o=`stat -f %m "$dir"`
  test $f -gt 0 -o $t -gt $o && 9 touch -c -t $t "$dir"
done
