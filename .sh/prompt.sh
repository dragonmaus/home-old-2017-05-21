if test x"$PS0" = x; then
  PS0=$0
else
  PS0=$PS0'>'$0
fi
export PS0
PS1=$PS0' '$PS1

exec_() {
  if test x${1+set} = xset; then
    PS0='>'$PS0
    PS0=${PS0%>*}
    PS0=${PS0#>}
    export PS0
  fi
  command exec ${1+"$@"}
}

alias exec='exec_ '
