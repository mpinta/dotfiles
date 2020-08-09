#!/bin/bash

BRIGHTNESS_LEVEL=5

print_help() {
    echo 'Help:'
    echo '[-h|--help] for help'
    echo '[-u|--up] for brightness up' 
    echo '[-d|--down] for brightness down'
    echo '[-c|--current] for current brightness'
}

brightness_up() {
    xbacklight -inc $BRIGHTNESS_LEVEL
}

brightness_down() {
    xbacklight -dec $BRIGHTNESS_LEVEL
}

current_brightness() {
    echo $(xbacklight -get)    
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) print_help; exit 0;;
        -u|--up) brightness_up; break;;
        -d|--down) brightness_down; exit 0;;
        -c|--current) current_brightness; exit 0;;
        *) echo "Unvalid parameter: $1"; exit 1;;
    esac
done

exit 0

