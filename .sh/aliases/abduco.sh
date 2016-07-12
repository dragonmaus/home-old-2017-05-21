for i in $_abduco_hook; do
  alias $i="abduco -A $i $i"
done
unset i _abduco_hook
