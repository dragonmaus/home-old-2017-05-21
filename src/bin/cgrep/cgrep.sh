#!/bin/sh -e

HC=${GREP_COLOUR_HEADER:-35}
SC=${GREP_COLOUR_SEP:-36}

H='['${HC}m
S='['${SC}m
R='[m[K'

e='s/^\([^	]*\)	/'$H'\1'$R$S:$R/

grep --colour=always --line-buffered --null ${1+"$@"} \
| tr '\0\t' '\t\0' \
| sed "$e" \
| tr '\t\0' '\0\t'
