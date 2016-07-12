die() (
  r=$1; l=$2; shift 2
  echo "${0##*/}: $l: $*" 1>&2
  exit $r
)
