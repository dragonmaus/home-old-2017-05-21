#!/bin/sh -e

cd /tmp/djb

find -H * -type f \( -name '*.[ch]' -o -name '*.[ch][12]' \) -print0 \
| xargs -0 grep -Flw ${1+"$*"} \
| sed 's/.*\///' \
| sort -u
