#!/bin/sh -e

e="
-not (
  -flags -offline
  -prune
)
-print0"

exec find -sx ${1+"$@"} $e
