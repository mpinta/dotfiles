#!/bin/bash

print_help() {
    echo 'Help:'
    echo '[-h|--help] for help'
    echo '[-wh|--wh-1000xm3] to connect wh-1000xm3'
    echo '[-yh|--yet-home] to connect yet home' 
}

initial_sequence() {
    echo -e 'power on\nagent on\ndefault-agent\nscan on' | bluetoothctl
    sleep 2
}

connect_wh_1000xm3() {
    initial_sequence
    echo -e 'connect 38:18:4C:D3:77:20' | bluetoothctl
    closing_sequence
}

connect_yet_home() {
    initial_sequence 
    echo -e 'connect 5A:5A:5A:00:1D:3A' | bluetoothctl
    closing_sequence
}

closing_sequence() {
    sleep 2
    echo -e 'scan off\nexit' | bluetoothctl
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) print_help; exit 0;;
        -wh|--wh-1000xm3) connect_wh_1000xm3; break;;
        -yh|--yet-home) connect_yet_home; exit 0;;
        *) echo "Unvalid parameter: $1"; exit 1;;
    esac
done

exit 0

