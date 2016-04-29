#!/bin/dash

cat $1 | curl -F 'f:l=<-' ix.io
