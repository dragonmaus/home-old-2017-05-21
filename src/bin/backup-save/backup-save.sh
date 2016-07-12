#!/bin/sh -e

dir=$HOME/var/backup

mkdir -p $dir
dir=`cd $dir; env - PATH=$PATH pwd`

file=$dir/$1.gz

rm -f "$file"{new}
gzip >"$file"{new}
fsync "$file"{new}
mv -f "$file"{new} "$file"

echo "Backup saved to $file"
