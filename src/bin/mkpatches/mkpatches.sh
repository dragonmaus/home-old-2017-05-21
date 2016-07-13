#!/bin/sh -e

umask 022

test ! -k . || ( echo 'Wrong working directory.'; exit 1 )
test -k .. || ( echo 'Wrong working directory.'; exit 1 )

here=`env - PATH=$PATH pwd`
name=`basename $here`
repo=/package/patches

mkdir -p $repo/$name

find -s . -name '*.orig' \
| sed -e 's|^\./||' -e 's|\.orig$||' -e p -e 's|/|__|g' \
| paste - - \
| while IFS=$'\t' read a b; do
    env - PATH=$PATH LC_ALL=C TZ=UTC diff -u $a.orig $a > $repo/$name/patch-$b \
    || :
  done
