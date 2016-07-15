#!/bin/sh -e

exec yuicompressor --type js ${1+"$@"}
