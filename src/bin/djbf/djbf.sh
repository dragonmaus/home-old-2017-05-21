#!/bin/sh -e

cd /tmp/djb

for f do
  f='-name '$f
  case $f in
  *.h) f='( '$f' -o '$f'[12] )';;
  esac
  find */ -type f $f -exec stat -f '%010m ' -n {} \; -exec sha512 -r {} \; \
  | sort -n \
  | sort -su -k 2,2 \
  | sort -k 1n,1n -k 3,3
done
