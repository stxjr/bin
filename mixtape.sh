#!/bin/sh
# Simple mixtape uploader by @sugoiuguu
# Requires curl and jshon (http://kmkeen.com/jshon/)

DEST="https://mixtape.moe/upload.php"
FILE="$@"
CMD=$(basename "$0")

print_usage() {
    echo 1>&2 "usage: $CMD file"
}

if [[ -z "$1" || -n "$2" ]]; then
    print_usage
    exit 1
else
    OUT=$(curl -sf -F files[]="@${FILE}" "${DEST}")

    if [[ $(echo "$OUT" | jshon -e success) =~ true ]]; then
        echo $(echo "$OUT" | jshon -e files -a -e url -u)
    else
        echo "An error occurred!"
        exit 1
    fi
fi
