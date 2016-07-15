#!/bin/sh -e

LC_ALL=C
export LC_ALL

tr -s '[:blank:]' ' ' \
| "$0"-sub \
| column -s '	' -t \
| sed 's/  - / - /'
