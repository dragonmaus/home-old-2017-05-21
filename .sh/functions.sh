for i in $ENVD/functions/*.sh; do
  test -x $i && . $i
done
