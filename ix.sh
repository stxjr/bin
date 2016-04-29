#!/bin/sh

cat $1 | curl -F 'f:l=<-' ix.io
