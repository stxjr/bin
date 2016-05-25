!/bin/sh

pkill lemonbar

fg=$(getcol 1)
altfg=$(getcol 7)
bg=e8e8ea

font="-fuyuki-tangerine-*-*-*-*-*-*-*-*-*-*-*-*"
glyphs="siji:pixelsize=10"

height=30
borderwidth=3

muslength=50

#w1=" "
#w2=" "
#w3=" "
#w4=" "
#w5=" "
#w6=" "

w1=""
w2=""
w3=""
w4=""
w5=""
w6=""

clk()
{
    echo -n " $(date "+%l:%M" | sed 's/ //g')"
}

dat()
{
    echo -n " $(date "+%B %d" | tr [A-Z] [a-z])"
}

mus()
{
    music=$(mpc current -f "[%title%[ in %album%][ by %artist%]]|%file%")

    playing=$(mpc status | sed -n 2p | awk '{print $1}')
    if [ $playing = "[playing]" ] ; then
        symbol=""
    elif [ $playing = "[paused]" ] ; then
        symbol=""
    fi

    echo -n "${symbol} ${music}"
}

musperc()
{
    percent="$(mpc status | awk '{print $4}' | sed -n 2p | tr -d "% ( )")"

    percent=$(( $percent / $((100 / $muslength)) ))

    buf=""
    for i in $(seq 1 $muslength); do
        if test $i -le $percent; then
            buf="${buf}%{F#$fg}─"
        else
            buf="${buf}%{F#$altfg}─%{F-}"
        fi
    done

    echo $buf
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
            WORKSPACE="%{F#$altfg}%{F-}${w1}%{F#$altfg}${w2}${w3}${w4}${w5}${w6}%{F-}";;
        " 1")
            WORKSPACE="%{F#$altfg}${w1}%{F-}${w2}%{F#$altfg}${w3}${w4}${w5}${w6}%{F-}";;
        " 2")
            WORKSPACE="%{F#$altfg}${w1}${w2}%{F-}${w3}%{F#$altfg}${w4}${w5}${w6}%{F-}";;
        " 3")
            WORKSPACE="%{F#$altfg}${w1}${w2}${w3}%{F-}${w4}%{F#$altfg}${w5}${w6}%{F-}";;
        " 4")
            WORKSPACE="%{F#$altfg}${w1}${w2}${w3}${w4}%{F-}${w5}%{F#$altfg}${w6}%{F-}";;
        " 5")
            WORKSPACE="%{F#$altfg}${w1}${w2}${w3}${w4}${w5}%{F-}${w6}%{F#$altfg}%{F-}";;

        esac
        echo "$WORKSPACE"
    }

floatbars()
{
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
        -g 200x$height+85+15 | sh &

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
        -g 200x$height+1075+15 | sh &

    # # music bar
    # while true; do
    #     buf="%{c}$(musperc)"
    #     echo "${buf}"
    #     sleep 0.1
    # done | lemonbar -f $glyphs \
    #     -f $font \
    #     -F \#$fg \
    #     -B \#$bg \
    #     -R \#$fg \
    #     -u 3 \
    #     -r $borderwidth \
    #     -g 400x$height+925+715 | sh &
}

topbar()
{
    while true; do
        buf="$(mus)"
        buf="${buf}%{c}$(wrk)"
        buf="${buf}%{r}$(bat)   $(dat)   $(clk)"
        echo "        ${buf}        "
        sleep 0.1
    done | lemonbar -f $glyphs \
        -f $font \
        -F \#$fg \
        -B \#$bg \
        -R \#$fg \
        -u 3 \
        -g x$height | sh &
}

floatbars
