#!/bin/sh -e

exec sudoedit -u derpibooru ${1+"$@"}
