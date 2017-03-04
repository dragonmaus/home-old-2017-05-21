#!/bin/sh -e

portfile=$HOME/.lein/repl-port

if test -s "$portfile"; then
  LEIN_REPL_PORT=`head <$portfile`
  export LEIN_REPL_PORT
  exec lein repl :connect
else
  exec lein repl :start
fi
