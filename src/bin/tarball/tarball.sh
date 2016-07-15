#!/bin/sh -e

. $HOME/lib/sh/stdlib.sh

findopts=
gzipopts=
taropts=
gzip=
opts=123456789svxz

usage() (die 100 usage "tarball [-$opts] path")

while getopts $opts opt; do
  case $opt in
  1|2|3|4|5|6|7|8|9)
    gzip=.gz
    gzipopts=$gzipopts$o
    ;;
  s|x)
    findopts=$findopts$o
    ;;
  v)
    gzipopts=$gzipopts$o
    taropts=$taropts$o
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

first=yes
for dir; do
  if test x$first = xyes; then
    first=no
  else
    echo 1>&2
  fi

  out=$dir.tar$gzip
  echo "Creating $out..." 1>&2

  rm -f "$out"{new}

  find ${findopts:+-$findopts} "$dir" -print0 \
  | tar -cn$taropts -T - -f - --null \
  | gzip -cn$gzipopts \
  > "$out"{new}

  touch -ch -r "$dir" "$out"{new}

  fsync "$out"{new}
  mv -f "$out"{new} "$out"
done
