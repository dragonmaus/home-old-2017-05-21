#!/bin/sh -e

cd /tmp/djb

find -H * -type f '(' -name '*.[ch]' -o -name '*.[ch][12]' ')' -exec grep -Flw "$*" {} + |
sed 's/.*\///' |
sort -u
