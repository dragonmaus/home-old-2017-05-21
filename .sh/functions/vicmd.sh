vicmd() {
  printf %b ${1+"$*"} | (multitee 0-1,3 | pbcopy) 3>&1
  printf '\n'
}
