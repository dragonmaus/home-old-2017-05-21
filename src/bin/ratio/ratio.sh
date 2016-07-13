#!/bin/sh

exec calc -p -- "printf('%r\\n', $1 / $2)"
