#!/bin/bash

VOLUME_LEVEL=5
DEFAULT_SINK=$(pactl info | grep 'Default Sink' | sed 's/^.*: //')

print_help() {
    echo 'Help:'
    echo '[-h|--help] for help'
    echo '[-u|--up] for volume up' 
    echo '[-d|--down] for volume down'
    echo '[-m|--mute] for mute toggle'
    echo '[-c|-current] for current volume'
}

volume_up() {
    pactl set-sink-volume $DEFAULT_SINK +$VOLUME_LEVEL%
}

volume_down() {
    pactl set-sink-volume $DEFAULT_SINK -$VOLUME_LEVEL%
}

mute_toggle() {
    if [[ $(current_mute) == "yes" ]]; then
        pactl set-sink-mute $DEFAULT_SINK 0
    else
        pactl set-sink-mute $DEFAULT_SINK 1
    fi
}

current_volume() {
    echo $(pactl list sinks | awk '/^\s+Name: /{indefault = $2 == "'$DEFAULT_SINK'"}/^\s+Volume: / && indefault {print $5; exit}' | sed 's/.$//')
}

current_mute() {
    echo $(pactl list sinks | awk '/^\s+Name: /{indefault = $2 == "'$DEFAULT_SINK'"}/^\s+Mute: / && indefault {print $2; exit}')
}

COMMAND=''
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) print_help; exit 0;;
        -u|--up) volume_up; break;;
        -d|--down) volume_down; exit 0;;
        -m|--mute) mute_toggle; exit 0;;
        -c|--current) current_volume; exit 0;;
        *) echo "Unvalid parameter: $1"; exit 1;;
    esac
done

