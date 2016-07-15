#!/bin/sh -e

exec jsmin --nomunge --preserve-semi ${1+"$@"}
