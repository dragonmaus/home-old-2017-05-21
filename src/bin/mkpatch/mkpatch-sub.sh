#!/bin/sh

for file do
  file=`echo "$file" | sed 's/^\.\///;s/\.orig$//'`
  env - LC_ALL=C TZ=UTC diff -u "$file".orig "$file"
done
