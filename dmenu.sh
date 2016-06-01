#!/bin/sh

dmenu_run -fn -fuyuki-tangerine-*-*-*-*-*-*-*-*-*-*-*-* \
    -nb \#222222 \
    -nf \#$(getcol 1) \
    -sb \#$(getcol 1) \
    -sf \#e8e8ea \
    -h 36 \
    -x 85 \
    -y 15 \
    -w 1196
