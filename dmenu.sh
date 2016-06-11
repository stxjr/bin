#!/bin/sh

dmenu_run -fn -sythe-tangerine-*-*-*-*-*-*-*-*-*-*-*-* \
    -nb \#dfdfdf \
    -nf \#$(getcol 1) \
    -sb \#$(getcol 1) \
    -sf \#dddddd \
    -h 36 \
    -x 85 \
    -y 15 \
    -w 1196
