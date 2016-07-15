#!/bin/sh -e

. $HOME/lib/sh/stdlib.sh

m=pdf

case "$1" in
--pdf) m=pdf; shift;;
--ps) m=ps; shift;;
-*) m=unknown; shift;;
esac

n=${1%.dvi}

case $m in
pdf) exec dvipdfmx "$n";;
ps) exec dvips "$n"; gzip -9fv "$n".ps;;
*) die 111 fatal "unknown mode";;
esac
