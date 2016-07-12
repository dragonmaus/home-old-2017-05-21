for i in $ENVD/environment/*.sh; do
  test -x $i && . $i
done
