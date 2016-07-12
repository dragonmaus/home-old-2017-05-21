#!/bin/sh -e

. "$HOME"/lib/sh/stdlib.sh

usage() (die 100 usage "dircp [-vx] source target")

v= x=
while getopts vx o; do
  case $o in
  v|x) eval $o=$o;;
  *) usage;;
  esac
done
shift `expr -- $OPTIND - 1`
test $# -eq 2 || usage

mkdir -p$v "$2"

(cd "$1"; exec find -s$x . -print0) \
| (cd "$1"; exec tar -cn$v -f - -T - --null) \
| (cd "$2"; exec tar -xp$v -f -)
