#!/bin/bash

MONITORS=$(xrandr -q | grep ' connected' | wc -l)

print_help() {
    echo 'Help:'
    echo '[-h|--help] for help'
    echo '[-s|--startup] for startup script'
    echo '[-ee|--enable-edp] to enable edp'
    echo '[-de|--disable-edp] to disable edp' 
    echo '[-oe|--only-edp] enable only edp'
    echo '[-o1|--only-dp1] enable only dp1'
    echo '[-o2|--only-dp2] enable only dp2'
}

startup() {
    if [[ $MONITORS = 3 ]]; then    
        xrandr --output eDP-1 --off --output DP-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal 
    elif [[ $MONITORS = 2 ]]; then
        xrandr --output eDP-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off
    fi
}

# Enable edp when one or more displays are connected
enable_edp() {
    xrandr --output eDP-1 --auto --right-of DP-1
}

disable_edp() {
    xrandr --output eDP-1 --off
}

# Enable only edp when two displays are connected
only_edp() {
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off
}

# Enable only dp1 when two displays are connected
only_dp1() {
    xrandr --output eDP-1 --off --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off
}

# Enable only dp2 when two displays are connected
only_dp2() {
    xrandr --output eDP-1 --off --output DP-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off
}

COMMAND=''
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) print_help; exit 0;;
        -s|--startup) startup; break;;
        -ee|--enable-edp) enable_edp; exit 0;;
        -de|--disable_edp) disable_edp; exit 0;;
        -oe|--only-edp) only_edp; exit 0;;
        -o1|--only-dp1) only_dp1; exit 0;;
        -o2|--only-dp2) only_dp2; exit 0;;
        *) echo "Unvalid parameter: $1"; exit 1;;
    esac
done

