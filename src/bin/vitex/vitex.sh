#!/bin/sh -e

n=${1%.tex}

vi "$n".tex
mktex "$n"
