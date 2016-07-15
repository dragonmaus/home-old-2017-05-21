#!/bin/sh -e

x=
case $1 in
-11) x=11; shift;;
esac

xmllint --c14n$x --noblanks ${1+"$@"} - \
| xmllint --format ${1+"$@"} -
