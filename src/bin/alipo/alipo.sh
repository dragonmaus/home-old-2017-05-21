#!/bin/sh

test x"$arches" = x && arches="x86_64 i386"
tmpdir=`mktemp -dt alipo-$$`

for file do
  lipo "$file" -info | grep '^Architectures in the fat file: ' || continue

  rm -f -r $tmpdir/arch $tmpdir/file
  mkdir -p $tmpdir/arch

  files=
  count=0
  for arch in $arches; do
    lipo "$file" -verify_arch $arch || continue
    lipo "$file" -output $tmpdir/arch/$arch -thin $arch || continue
    files=$files' '$tmpdir/arch/$arch
    count=`expr $count + 1`
  done

  case $count in
  0)
    continue
    ;;
  1)
    mv -f $files $tmpdir/file
    ;;
  *)
    lipo $files -output $tmpdir/file -create
    ;;
  esac

  cmp -s "$file" $tmpdir/file && rm -f $tmpdir/file && continue
  cp -n -p "$file" "$file".orig
  rm -f "$file"{new}
  cp -p $tmpdir/file "$file"{new}
  touch -c -h -r "$file" "$file"{new}
  fsync "$file"{new}
  mv -f "$file"{new} "$file"
done
