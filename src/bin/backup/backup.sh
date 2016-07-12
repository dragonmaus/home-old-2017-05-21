#!/bin/sh -e

date=`env - TZ=UTC date -ju +%FT%TZ`
host=`hostname | sed 's/\..*//'`

e="
-not (
  -flags -offline
  -prune
)
-flags -arch
-not (
  -type d
  -prune
  -exec $0-sub {} ;
)
-print0"

if test `id -u` -eq 0; then
  sudo() (exec ${1+"$@"})
else
  sudo -v
fi

sync

sudo find -sx / $e \
| sudo tar -cnPv -f - -T - --null \
| book bin/backup-save "$host"@"$date".tar
