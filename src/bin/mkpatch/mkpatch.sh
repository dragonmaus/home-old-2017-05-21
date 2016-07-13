#!/bin/sh -e

find -sx . -name '*.orig' -print0 \
| xargs -0 "$0"-sub
