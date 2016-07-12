#!/bin/sh -e

exec ls -AFl ${1+"$@"}
