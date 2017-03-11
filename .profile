set -a

GPG_TTY=`tty`
LESS=iMR
LESSHISTFILE=/dev/null
MAKEOBJDIRPREFIX=$HOME/obj
MORE=iR
PAGER=more; MANPAGER=$PAGER' -s'
PATH=$PATH:$HOME/.gem/ruby/2.3/bin:$HOME/.local/bin:$HOME/.rbenv/bin:$HOME/.stack/programs/x86_64-freebsd/ghc-7.10.3/bin
which npm >/dev/null 2>/dev/null && PATH=$PATH:`npm bin`
RUBYLIB=$HOME/lib/ruby
SYSTEM=`uname -s | tr A-Z a-z`
TOP='-atu -s1'
pi=π
tau=τ

set +a

test -x /usr/games/fortune && /usr/games/fortune freebsd-tips

exec ssh-agent ${SHELL##*/} ${1+"$@"}
