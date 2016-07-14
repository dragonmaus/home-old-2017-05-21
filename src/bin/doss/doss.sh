#!/bin/sh -e

for file do
  time=`env TZ=UTC stat -f %Sm -t %FT%TZ "$file"`
  for attr in `xattr "$file"`; do
    xattr -d "$attr" "$file"
  done
  rm -f "$time".png{new}
  cp -p "$file" "$time".png{new}
  rm -f "$file"
  fsync "$time".png{new}
  cp -p "$time".png{new} "$HOME"/Pictures/"Screen Shots"/"$time".png
  cp -p "$time".png{new} "$HOME"/www/screenshots/"$time".png
  rm -f "$time".png{new}
  open https://dragonmaus.tk/screenshots/"$time".png
done
