#!/bin/sh -e

date=`env - TZ=UTC date -ju +%FT%TZ`
host=`hostname | sed 's/\..*//'`

e="
! (
  -flags -offline
  -prune
)
-flags -arch
! (
  -type d
  -prune
  -exec $0-sub {} ;
)
-print0"

case `id -u` in
0) sudo() (exec ${1+"$@"});;
*) sudo -v;;
esac

sync

sudo find -sx / $e \
| sudo tar -cnPv -f - -T - --null \
| book bin/backup-save "$host"@"$date".tar
