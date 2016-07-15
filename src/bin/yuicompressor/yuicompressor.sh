#!/bin/sh -e

exec java -jar $HOME/old/lib/yuicompressor-2.4.8.jar ${1+"$@"}
