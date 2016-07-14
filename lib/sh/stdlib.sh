die() {
  c=${0##*/}; r=$1; l=$2; shift 2
  warn "$c: $l: $*"
  exit $r
}
warn() {
  echo ${1+"$@"} 1>&2
}
