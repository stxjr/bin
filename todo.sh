#!/bin/sh

file=~/var/todo

[ -z $1 ] && cat $file

[ "$1" = "-e" ] && ${EDITOR:-vim} $file
