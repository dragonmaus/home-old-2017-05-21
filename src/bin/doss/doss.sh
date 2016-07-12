#!/bin/sh

set -e

for f; do
  t=`env TZ=UTC stat -f %Sm -t '%FT%T' "$f"`
  for a in `xattr "$f"`; do
    xattr -d "$a" "$f"
  done
  rm -f "$t".png.new
  mv -v "$f" "$t".png.new
  fsync "$t".png.new
  mv -fv "$t".png.new "$t".png
  cp -npv "$t".png "$HOME"/www/screenshots/"$t".png
  mv -nv "$t".png "$HOME"/Pictures/'Screen Shots'/"$t".png
  open https://dragonmaus.tk/screenshots/"$t".png
done
