#!/bin/sh -e

n=${1%.dvi}

dvips -o '!lp' "$n"
