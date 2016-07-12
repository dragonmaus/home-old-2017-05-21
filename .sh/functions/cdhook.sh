cdhook() {
  PWD=`env - PATH=$PATH pwd`
  export PWD
  printf '\033];%s%s/\007' "$HOSTNAME" "${PWD%/}" >/dev/tty
}
for i in cd $_cdhook_hook; do
  eval $i'() { command '$i' ${1+"$@"} && cdhook; }'
done
unset i _cdhook_hook
cdhook
