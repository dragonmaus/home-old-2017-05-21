#!/bin/sh -e

cd /tmp/djb

for s do
  find -H * -type f \( -name '*.[ch]' -o -name '*.[ch][12]' \) -print0 \
  | xargs -0 grep -FHw "$s"
done
