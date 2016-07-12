for i in $ENVD/aliases/*.sh; do
  test -x $i && . $i
done
