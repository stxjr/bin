#!/bin/sh

# define options
bg=e8e8ea
fg=$(getcol 1)
height=30
length=200

duration=5 # in seconds

(echo "%{c} $@"; sleep $duration) | \
    lemonbar -f -fuyuki-tangerine-*-*-*-*-*-*-*-*-*-*-*-* \
    -f siji:pixelsize=10 \
    -B \#$bg \
    -F \#$fg \
    -g ${length}x${height}+1150+45
    # -g ${length}x${height}+1150+715
