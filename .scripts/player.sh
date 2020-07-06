#!/bin/bash

print_help() {
    echo 'Help:'
    echo '[-h|--help] for help'
    echo '[-pl|--play] for player play' 
    echo '[-pa|--pause] for player pause'
    echo '[-ne|--next] for player next' 
    echo '[-pr|--previous] for player previous'
}

player_play() {
    playerctl play-pause 
}

player_pause() {
    playerctl pause-pause
}

player_next() {
    playerctl next
}

player_previous() {
    playerctl previous
}

COMMAND=''
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) print_help; exit 0;;
        -pl|--play) player_play; break;;
        -pa|--pause) player_pause; exit 0;;
        -ne|--next) player_next; exit 0;;
        -pr|--previous) player_previous; exit 0;;
        *) echo "Unvalid parameter: $1"; exit 1;;
    esac
done

