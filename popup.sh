#!/bin/dash

# define options
bg=222222
fg=$(getcol 1)
height=40
length=200

duration=5 # in seconds

(echo "%{c} $@"; sleep $duration) | \
    lemonbar -f -fuyuki-tangerine-*-*-*-*-*-*-*-*-*-*-*-* \
    -f siji:pixelsize=10 \
    -B \#$bg \
    -F \#$fg \
    -g ${length}x${height}+1150+45
    # -g ${length}x${height}+1150+715
