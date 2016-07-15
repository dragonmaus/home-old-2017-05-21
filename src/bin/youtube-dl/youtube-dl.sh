#!/bin/sh -e

c=${0%.sh}.py
t=`stat -f %m "$c"`

test `expr $t + 86400` -ge `date -ju +%s` || "$c" --update

exec "$c" ${1+"$@"}
