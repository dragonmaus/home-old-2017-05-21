#!/usr/bin/sed -f

s/ - /	- /
s/^\([^ ,]\{1,\},\) /\1\
/
P
D
