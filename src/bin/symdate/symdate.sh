#!/bin/sh -e

. $HOME/lib/sh/stdlib.sh

usage() (die 100 usage 'symdate [-f] symlink...')

a= f=0
while getopts f opt; do
  case $opt in
  f) f=`expr $f + 1`; a=$a' -f';;
  *) usage;;
  esac
done
shift `expr $OPTIND - 1`

test $# -gt 0 || usage

temp=`mktemp -t symdate-$$`
trap -- "rm -f '$temp'" EXIT

for link do
  test -h "$link" || die 111 fatal "$link: Not a symbolic link"

  target=`readlink "$link"`
  case $target in
  /*) ;;
  *) dir=`dirname "$link"`; target=$dir/$target;;
  esac

  if ! test -e "$target"; then
    target=$temp
    touch -ch -r /etc/epoch "$target"
  elif test -h "$target"; then
    symdate $a "$target"
  fi

  test $f -gt 0 -o `stat -f %m "$target"` -gt `stat -f %m "$link"` && touch -ch -r "$target" "$link"
done
