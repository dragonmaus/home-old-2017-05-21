#!/bin/sh -e

. "$HOME"/lib/sh/stdlib.sh

findopts=
gzipopts=
gzip=
opts=123456789svxz
verbose=no

usage() (die 100 usage "sharball [-$opts] path")

while getopts $opts o; do
  case $o in
  1|2|3|4|5|6|7|8|9)
    gzip=.gz
    gzipopts=$gzipopts$o
    ;;
  s|x)
    findopts=$findopts$o
    ;;
  v)
    gzipopts=$gzipopts$o
    verbose=yes
    ;;
  z)
    gzip=.gz
    ;;
  *)
    usage
    ;;
  esac
done
shift `expr $OPTIND - 1`
test x"$1" = x && usage

test -e "$1" || die 111 fatal "$1: No such file or directory"

test x$gzip = x && gzip() (exec cat)
test x$verbose = xyes && show() ((tee /dev/fd/2 2>&3 | tr '\0' '\n') 3>&1 1>&2)

first=yes
for dir; do
  if test x$first = xyes; then
    first=no
  else
    echo 1>&2
  fi

  out=$dir.shar$gzip
  echo "Creating $out..." 1>&2

  rm -f "$out"{new}

  find ${findopts:+-$findopts} "$dir" -print0 \
  | show \
  | xargs -0 shar \
  | gzip -cn$gzipopts \
  > "$out"{new}

  touch -c -r "$dir" "$out"{new}

  fsync "$out"{new}
  mv -f "$out"{new} "$out"
done
