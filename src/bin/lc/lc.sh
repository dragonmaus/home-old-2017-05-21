#!/bin/sh -e

if isatty 1; then
  CLICOLOR_FORCE=$CLICOLOR
  export CLICOLOR_FORCE
else
  COLUMNS=`tput cols`
  export COLUMNS
fi

ls -1AF ${1+"$@"} | cols
