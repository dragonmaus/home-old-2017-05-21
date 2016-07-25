#!/bin/sh -e

. $HOME/lib/sh/stdlib.sh

usage() (die 100 usage 'crunch [bom | dos | eof | eol] path [expression]')

case $1 in
bom) filter() (iconv -f utf-8 -t utf-32 | iconv -f utf-32 -t utf-8);;
dos) filter() (exec lefix);;
eof) filter() (exec sed '');;
eol) filter() (exec sed 's/[	 ]\{1,\}$//');;
*) usage;;
esac
shift

find ${1+"$@"} -type f -print \
| file -Nnp -F '	' -e soft --mime-type -f - \
| sed -n 's|	 text/plain$||p' \
| while read f; do
  rm -f "$f"{new}
  filter <"$f" >"$f"{new}
  fsync "$f"{new}
  if cmp -s "$f" "$f"{new}; then
    rm -f "$f"{new}
  else
    mv -f "$f"{new} "$f"
  fi
done
