duh() (
  tmp=`mktemp -t duh-$$` || exit
  trap "rm -f $tmp" 0
  du -h ${1+"$@"} >$tmp || exit
  sort -n -o $tmp $tmp || exit
  for i in B K M G; do
    grep -F "$i	" <$tmp
  done
)
