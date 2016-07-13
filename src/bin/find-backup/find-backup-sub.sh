#!/bin/sh -e

e="
! (
  -flags -offline
  -prune
  -exec printf \033[1;31m%s\033[m\n {} ;
)
-exec printf \033[1;32m%s\033[m\n {} ;"

exec find -sx ${1+"$@"} $e
