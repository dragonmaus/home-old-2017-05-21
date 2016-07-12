#!/bin/sh -e

e="
-not (
  -flags -offline
  -prune
  -exec printf \033[1;31m%s\033[m\n {} ;
)
-flags -arch
-not (
  -type d
  -prune
  -exec $0-sub {} ;
)
-exec printf \033[1;32m%s\033[m\n {} ;"

sync

exec find ${1+"$@"} $e
