#!/bin/sh

LC_ALL=C
export LC_ALL

tr -s '[:blank:]' ' ' \
| sed 's/ - /	- /
s/^\([^ ,]\{1,\},\) /\1\
/
P
D' \
| column -s '	' -t \
| sed 's/  - / - /'
