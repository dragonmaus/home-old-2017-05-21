#!/bin/sh -e

c=`echo help ${1+"$@"}`
exec vim -c "$c" -c only
