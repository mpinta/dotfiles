#!/bin/bash

print_help() {
    echo 'Help:'
    echo '[-h|--help] for help'
    echo '[-s|--startup] for startup script'
    echo '[-g|--gui] for gui'
    echo '[-p|--to-pictures] to save to pictures'
    echo '[-c|--to-clipboard] to save to clipboard'
}

startup() {
    flameshot &
}

gui() {
    flameshot gui
}

to_pictures() {
    flameshot screen -p $HOME/pictures
}

to_clipboard() {
    flameshot screen -c 
}

COMMAND=''
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) print_help; exit 0;;
        -s|--startup) startup; break;;
        -g|--gui) gui; exit 0;;
        -p|--to-pictures) to_pictures; exit 0;;
        -c|--to-clipboard) to_clipboard; exit 0;;
        *) echo "Unvalid parameter: $1"; exit 1;;
    esac
done

