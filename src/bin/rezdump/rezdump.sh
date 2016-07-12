#!/bin/sh

filter() {
  sed 's/^data '\''\(.*\)'\'' (\(-\{0,1\}[0-9]\{1,\}\).*) {$/\1.\2/'
}

here=`env - PATH=$PATH pwd`
LC_ALL=C
export LC_ALL

for f do
  if test -s "$f"/..namedfork/rsrc; then
    DeRez "$f" > "$f".r
  else
    DeRez -useDF "$f" > "$f".r
  fi
  mkdir -p "$f".d
  i=`grep '^$' "$f".r | wc -l`
  i=`expr $i - 2`
  if test $i -ge 0; then
    csplit -f "$f".d/ -n 6 "$f".r '/^};/+2' {$i}
  else
    cp -p "$f".r "$f".d/000000
  fi
  cd "$f".d
  for g in ??????; do
    h=`head -1 < "$g" | filter | iconv -f mac -t utf-8`
    h=${h%.*}.`printf %6d ${h#*.}`
    mv -nv "$g" "$h".r
  done
  cd "$here"
  touch -chr "$f" "$f".d "$f".d/* "$f".r
done
