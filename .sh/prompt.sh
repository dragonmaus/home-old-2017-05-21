if test x"$PSO" = x; then
  PSO=$0
else
  PSO=$PSO'>'$0
fi
export PSO
PS1=$PSO' '$PS1

exec_() {
  if test x${1+set} = xset; then
    PSO='>'$PSO
    PSO=${PSO%>*}
    PSO=${PSO#>}
    export PSO
  fi
  command exec ${1+"$@"}
}

alias exec='exec_ '
