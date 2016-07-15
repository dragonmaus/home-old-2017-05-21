#!/bin/sh -e

exec qrencode --margin=2 --type=UTF8 ${1+"$@"}
