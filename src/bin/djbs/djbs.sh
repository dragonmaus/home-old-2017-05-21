#!/bin/sh -e

cd /tmp/djb

for s do
  find -H * -type f '(' -name '*.[ch]' -o -name '*.[ch][12]' ')' -exec grep -FHw "$s" {} +
done
