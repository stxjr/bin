#!/bin/dash
pkill lemonbar

fg=$(getcol 1)
bg=222222
# font="metis:pixelsize=10"
font="-fuyuki-tangerine-*-*-*-*-*-*-*-*-*-*-*-*"
glyphs="siji:pixelsize=10"

height=30

clk() {
    echo -n " $(date "+%l:%M" | sed 's/ //g')"
}

dat() {
    echo -n " $(date "+%a, %B %d" | tr [A-Z] [a-z])"
}

mus() {
    music=$(mpc current -f '[%title% [- %album%]]|%file%')
    
    playing=$(mpc status | sed -n 2p | awk '{print $1}')
    if [ $playing = "[playing]" ] ; then
        echo -n "%{+o}${music}%{-o}"
    elif [ $playing = "[paused]" ] ; then
        echo -n "${music}"
    fi

    percent=$(mpc status | sed -n 2p | awk '{print $4}' | tr -d '()%')
}

win() {
    echo -n " $(xtitle)"
}

vol() {
    percent=$(amixer get Master | sed -n 5p | awk '{print $3}')

    echo -n " ${percent}"
}

bat() {
    percent=$(cat /sys/class/power_supply/BAT1/capacity)
    status=$(cat /sys/class/power_supply/BAT1/status)

    fullthing="${symbol} ${percent}"

    if test $status = "Charging"; then
        symbol=""
        echo -n "${symbol} ${percent}"
    elif test $status = "Full"; then
        symbol=""
        echo -n "%{+o}${symbol} ${percent}%{-o}"
    else
        if test $percent -gt 66; then
            symbol=""
            echo -n "${symbol} ${percent}"
        elif test $percent -gt 34; then
            symbol=""
            echo -n "${symbol} ${percent}"
        else
            symbol=""
            echo -n "%{+u}${symbol} ${percent}%{-u}"
        fi
    fi
}

while true; do
    buf="$(mus)"
    buf="${buf}%{c}"
    buf="${buf}%{r}    $(vol)    $(bat)    $(dat)    $(clk)"
    echo "            ${buf}            "
    
done | lemonbar -f $glyphs \
    -f $font \
    -F \#$fg \
    -U \#$fg \
    -B \#$bg \
    -u 3 \
    -g x$height | sh &

# second bar for workspaces on top of the normal one
sleep 0.01; bspc subscribe | bspwmdesktop | lemonbar \
    -B \#00000000 \
    -u 2 \
    -g 100x${height}+636 \
    -f $font -f $glyphs &
