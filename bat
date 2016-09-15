#!/bin/sh

out=$(cat /sys/class/power_supply/BAT1/capacity)

status=$(cat /sys/class/power_supply/BAT1/status)
if test $status = "Charging"; then
    sym=""
elif test $status = "Full"; then
    sym=""
elif test $status = "Unknown"; then
    sym="?"
else
    if test $out -gt 66; then
        sym=""
    elif test $out -gt 34; then
        sym=""
    else
        sym=""
    fi
fi

if [ "$1" = "-s" ]; then
    echo "$out"
else
    echo "%{R} $sym %{R}  $out"
fi
