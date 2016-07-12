#!/bin/sh -e

v=
x=
while getopts vx opt; do
  case $opt in
  v|x)
    eval $opt=$opt
    ;;
  '?')
    echo 'dircp: usage: dircp [-vx] source target' 1>&2
    exit 100
    ;;
  esac
done
shift `expr '(' $OPTIND - 1 ')'`

s=$1
t=`basename "$s"`
t=$2/$t

mkdir -p$v "$t"

(cd "$s" && exec find -s$x . -print0) |
(cd "$s" && exec tar -cn$v -f - -T - --null) |
(cd "$t" && exec tar -xp$v -f -)
