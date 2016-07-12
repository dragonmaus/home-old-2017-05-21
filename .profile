set -a

LESS=iMR
LESSHISTFILE=/dev/null
MAKEOBJDIRPREFIX=$HOME/obj
MORE=iR
PAGER=more; MANPAGER=$PAGER' -s'
PATH=$PATH:$HOME/.local/bin:$HOME/.stack/programs/x86_64-freebsd/ghc-7.10.3/bin
RUBYLIB=$HOME/lib/ruby
SYSTEM=`uname -s | tr A-Z a-z`
TOP='-atu -s1'

set +a

test -x /usr/games/fortune && /usr/games/fortune freebsd-tips
