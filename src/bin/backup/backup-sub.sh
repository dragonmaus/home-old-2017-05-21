#!/bin/sh -e

e="
! (
  -flags -offline
  -prune
)
-print0"

exec find -sx ${1+"$@"} $e
