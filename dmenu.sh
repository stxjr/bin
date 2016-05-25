#!/bin/sh

dmenu_run -fn -fuyuki-tangerine-*-*-*-*-*-*-*-*-*-*-*-* \
    -nb \#e8e8ea \
    -nf \#$(getcol 1) \
    -sb \#$(getcol 1) \
    -sf \#e8e8ea \
    -h 36 \
    -x 35 \
    -y 15 \
    -w 1296
