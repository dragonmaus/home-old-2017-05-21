#!/bin/sh -e

. $HOME/lib/sh/stdlib.sh

usage() (die 100 usage 'doss [-x] file...')

export=no

while getopts x opt; do
  case $opt in
  x) export=yes;;
  *) usage;;
  esac
done
shift `expr $OPTIND - 1`

test x"$1" = x && usage

for file do
  test -f "$file" || die 111 fatal "$file: No such file or directory"
  time=`env TZ=UTC stat -f %Sm -t %FT%TZ "$file"`
  for attr in `xattr "$file"`; do
    xattr -d "$attr" "$file"
  done
  rm -f "$time".png{new}
  cp -p "$file" "$time".png{new}
  rm -f "$file"
  fsync "$time".png{new}
  cp -p "$time".png{new} "$HOME"/Pictures/"Screen Shots"/"$time".png
  if test x$export = xyes; then
    cp -p "$time".png{new} "$HOME"/www/screenshots/"$time".png
    open https://dragonmaus.tk/screenshots/"$time".png
  fi
  rm -f "$time".png{new}
done
