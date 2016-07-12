lsc() {
  case $1 in
  off) unset CLICOLOR;;
  on ) CLICOLOR=1; export CLICOLOR;;
  esac
}
