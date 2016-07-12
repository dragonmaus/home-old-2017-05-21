a=`echo $PATH | tr : ' '`
b=`find $a -name 'python*' ! -name 'python*-config' -print0 2>/dev/null | xargs -0 basename | sort -u`
for c in $b; do
  d=`echo -n $c | tr . _`
  test x$c = x$d || alias $c=$d
  eval $d'() (stty=`stty -g`; command '$c' ${1+"$@"}; r=$?; stty $stty; exit $r)'
done
unset a b c d
