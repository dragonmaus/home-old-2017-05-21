#!/bin/sh -e

exec optipng -o 7 -fix -force -zm 1-9 -strip all ${1+"$@"}
