#!/bin/sh -e

. $HOME/lib/sh/stdlib.sh

usage() (die 100 usage 'imgcat [filename ...]')

if base64 --version 2>&1 | grep -Eiq 'gnu|fourmilab'; then
  decode() (exec base64 -d ${1+"$@"})
else
  decode() (exec base64 -D ${1+"$@"})
fi

print_image() {
  data=`base64`
  if test x"$1" = x; then
    name=
  else
    printf '%s\n' "$1"
    name='name='`printf %s "$1" | base64`';'
  fi
  size=`printf %s "$data" | decode | wc -c`

  printf '\033]1337;File=%ssize=%d;inline=1:%s\007\n' "$name" "$size" "$data"
}

if `isatty 0`; then
  test $# -gt 0 || usage

  for file do
    test -e "$file" || die 111 fatal "$file: No such file or directory"
    test -d "$file" && continue

    print_image "$file" <"$file"
  done
else
  test $# -le 1 || usage

  print_image "$1"
fi
