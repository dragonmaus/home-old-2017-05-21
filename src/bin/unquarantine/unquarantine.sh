#!/bin/sh -e

exec unattr com.apple.quarantine ${1+"$@"}
