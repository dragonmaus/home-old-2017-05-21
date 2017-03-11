#!/bin/sh -e

svgo -i - -o - -p 10 --multipass \
| xmllint --c14n11 - \
| svgo -i - -o - -p 10 --multipass --indent=2 ${1+"$@"}
