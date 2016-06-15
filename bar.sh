#!/bin/sh

pkill lemonbar

fg=$(getcol 1)
altfg=$(getcol 7)
borderfg=$(getcol 1)
bg=$(getcol bg)

fgf="%{F#$fg}"
altfgf="%{F#$altfg}"
bgf="%{F#$bg}"
endf="%{F-}"

font="-sythe-tangerine-*-*-*-*-*-*-*-*-*-*-*-*"
glyphs="siji:pixelsize=10"

height=30
borderwidth=2

w1=""
w2=""
w3=""
w4=""
w5=""
w6=""

wrk()
{
    NUMB=$(xprop -root -notype _NET_CURRENT_DESKTOP | cut -d= -f2);
    case "$NUMB" in
        " 0")
            WORKSPACE="$altfgf%{F-}${w1}$altfgf${w2}${w3}${w4}${w5}${w6}%{F-}";;
        " 1")
            WORKSPACE="$altfgf${w1}%{F-}${w2}$altfgf${w3}${w4}${w5}${w6}%{F-}";;
        " 2")
            WORKSPACE="$altfgf${w1}${w2}%{F-}${w3}$altfgf${w4}${w5}${w6}%{F-}";;
        " 3")
            WORKSPACE="$altfgf${w1}${w2}${w3}%{F-}${w4}$altfgf${w5}${w6}%{F-}";;
        " 4")
            WORKSPACE="$altfgf${w1}${w2}${w3}${w4}%{F-}${w5}$altfgf${w6}%{F-}";;
        " 5")
            WORKSPACE="$altfgf${w1}${w2}${w3}${w4}${w5}%{F-}${w6}$altfgf%{F-}";;
        *)
            WORKSPACE="$altfgf${w1}${w2}${w3}${w4}${w5}${w6}";;
    esac
    echo "$WORKSPACE"
}

while true; do
    buf="%{c}$(wrk)" 
    echo "$buf"
    sleep 0.1
done | lemonbar \
    -f $glyphs \
    -f $font \
    -F \#$fg \
    -B \#$bg \
    -R \#$borderfg \
    -u 3 \
    -r $borderwidth \
    -g 150x$height+606+15 | sh &
