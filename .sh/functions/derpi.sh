for i in link slug; do
  eval $i'() { echo -n ${1+"$*"} | derpi'$i' | (multitee 0-1,3 | tr -d \\n | pbcopy) 3>&1; }'
done
unset i
