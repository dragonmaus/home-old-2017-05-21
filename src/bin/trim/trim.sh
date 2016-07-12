#!/bin/sh -e

    t=35
l=57    r=57
    b=79

for file do
  eval `gm identify -format 'w=%w;h=%h;' "$file"`
  w=`expr '(' $w - $l - $r ')'`
  h=`expr '(' $h - $t - $b ')'`
  rm -f "{new}$file"
  gm convert "$file" -crop ${w}x${h}+${l}+${t} +repage +page -strip "{new}$file"
  touch -ch -r "$file" "{new}$file"
  fsync "{new}$file"
  mv -f "{new}$file" "${file%.*}_trim.${file##*.}"
done
