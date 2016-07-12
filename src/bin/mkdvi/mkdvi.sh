#!/bin/sh -e

m=pdf

case "$1" in
--pdf)
  m=pdf
  shift
  ;;
--ps)
  m=ps
  shift
  ;;
-*)
  m=unknown
  shift
  ;;
esac

n=${1%.dvi}

case $m in
pdf)
  dvipdfmx "$n"
  ;;
ps)
  dvips "$n"
  gzip -9fv "$n".ps
  ;;
*)
  echo "$0: fatal: unknown mode" 1>&2
  exit 111
  ;;
esac
