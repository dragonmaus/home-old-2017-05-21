#!/bin/sh -e

fatal() { echo "mkpackage: fatal: $*" 1>&2; exit 111; }
usage() { echo 'mkpackage: usage: mkpackage name version' 1>&2; exit 100; }

test -n "$1" -a -n "$2" || usage
name="$1"; version="$2"; shift 2
test -z "$*" || usage

package=`echo "$name $version" \
| tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '\
     'abcdefghijklmnopqrstuvwxyz-'`

test -d $package || fatal 'Wrong working directory.'

echo 'Checking package version...'
rm -f $package/package/version'{new}'

(echo "$name $version"; exec sed 1d < $package/package/version) \
> $package/package/version'{new}'

fsync $package/package/version'{new}' || sync

if cmp -s $package/package/version $package/package/version'{new}'; then
  echo 'Package version unchanged.'
  rm -f $package/package/version'{new}'
else
  echo 'Updating package version...'
  mv -f $package/package/version'{new}' $package/package/version
fi

if test `find $package -type l | wc -l` -gt 0; then
  echo 'Creating local tarball...'
  find -s $package ! -samefile $package/package/version \
    -exec touch -chr $package/package/version {} +

  rm -f $package.tar.gz'{new}'

  find -s $package -print0 \
  | tar -cnf /dev/fd/1 -T /dev/fd/0 --null \
  | gzip -9cn \
  > $package.tar.gz'{new}'

  fsync $package.tar.gz'{new}' || sync

  mv -f $package.tar.gz'{new}' $package.tar.gz
fi

echo 'Creating distribution tarball...'
find -s $package ! -samefile $package/package/version \
  -exec touch -cr $package/package/version {} +

rm -f /package/dist/$package.tar.gz'{new}'

find -s $package -print0 \
| tar -cLnf /dev/fd/1 -T /dev/fd/0 --null \
| gzip -9cn \
> /package/dist/$package.tar.gz'{new}'

fsync /package/dist/$package.tar.gz'{new}' || sync

mv -f /package/dist/$package.tar.gz'{new}' /package/dist/$package.tar.gz
