#!/bin/sh

attr=$1
shift

find ${1+"$@"} -xattrname "$attr" -print0 |
xargs -0 xattr -d -s "$attr"
