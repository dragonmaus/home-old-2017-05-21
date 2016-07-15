#!/bin/sh -e

exec dvips -o '!lp' "${1%.dvi}"
