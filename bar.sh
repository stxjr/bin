#!/bin/sh
pkill lemonbar

fg=$(getcol 1)
altfg=$(getcol 7)
bg=e8e8ea
font="-fuyuki-tangerine-*-*-*-*-*-*-*-*-*-*-*-*"
glyphs="siji:pixelsize=10"
height=30
borderwidth=3

clk()
{
    echo -n " $(date "+%l:%M" | sed 's/ //g')"
}

dat()
{
    echo -n " $(date "+%B %d" | tr [A-Z] [a-z])"
}

mus()
{
    music=$(mpc current -f '[%title% [- %album%]]|%file%')

    playing=$(mpc status | sed -n 2p | awk '{print $1}')
    if [ $playing = "[playing]" ] ; then
        echo -n " ${music}"
    elif [ $playing = "[paused]" ] ; then
        echo -n " ${music}"
    fi
}

win()
{
    echo -n " $(xtitle)"
}

vol()
{
    percent=$(amixer get Master | sed -n 5p | awk '{print $3}')

    echo -n " ${percent}"
}

bat()
{
    percent=$(cat /sys/class/power_supply/BAT1/capacity)
    status=$(cat /sys/class/power_supply/BAT1/status)

    fullthing="${symbol} ${percent}"

    if test $status = "Charging"; then
        symbol=""
        echo -n "${symbol} ${percent}"
    elif test $status = "Full"; then
        symbol=""
        echo -n "${symbol} ${percent}"
    else
        if test $percent -gt 66; then
            symbol=""
            echo -n "${symbol} ${percent}"
        elif test $percent -gt 34; then
            symbol=""
            echo -n "${symbol} ${percent}"
        else
            symbol=""
            echo -n "${symbol} ${percent}"
        fi
    fi
}

wrk()
{
    NUMB=$(xprop -root -notype _NET_CURRENT_DESKTOP | cut -d= -f2);
    case "$NUMB" in
        " 0")
            WORKSPACE="%{F#$altfg}%{F-}%{F#$altfg}%{F-}";;
        " 1")
            WORKSPACE="%{F#$altfg}%{F-}%{F#$altfg}%{F-}";;
        " 2")
            WORKSPACE="%{F#$altfg}%{F-}%{F#$altfg}%{F-}";;
        " 3")
            WORKSPACE="%{F#$altfg}%{F-}%{F#$altfg}%{F-}";;
        " 4")
            WORKSPACE="%{F#$altfg}%{F-}%{F#$altfg}%{F-}";;
        " 5")
            WORKSPACE="%{F#$altfg}%{F-}%{F#$altfg}%{F-}";;

        esac
    echo "$WORKSPACE"
}

# left bar
while true; do
    buf="%{c}$(mus)"
    echo "${buf}"
    sleep 0.1
done | lemonbar -f $glyphs \
    -f $font \
    -F \#$fg \
    -B \#$bg \
    -R \#$fg \
    -u 3 \
    -r $borderwidth \
    -g 200x$height+35+15 | sh &

# middle bar
while true; do
    buf="%{c}$(wrk)" 
    echo $buf
    sleep 0.1
done | lemonbar -f $glyphs \
    -f $font \
    -F \#$fg \
    -B \#$bg \
    -R \#$fg \
    -u 3 \
    -r $borderwidth \
    -g 150x$height+606+15 | sh &

# right bar
while true; do
    buf="%{c}$(bat)   $(dat)   $(clk)"
    echo "${buf}"
    sleep 0.1
done | lemonbar -f $glyphs \
    -f $font \
    -F \#$fg \
    -B \#$bg \
    -R \#$fg \
    -u 3 \
    -r $borderwidth \
    -g 200x$height+1125+15 | sh &
