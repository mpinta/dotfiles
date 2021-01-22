#!/bin/bash

ADDRESS='192.168.0.199'

print_help() {
    echo 'Help:'
    echo '[-h|--help] for help'
    echo '[-f|--file] to select file' 
    echo '[-s|--subtitles] to select subtitles'
}

cast() {
    castnow --address $ADDRESS $FILE --subtitles $SUBTITLES --subtitle-scale 1.2 --subtitle-color '#FFFFFF' --tomp4 --ffmpeg-c:a ac3
}

FILE=''
SUBTITLES=''
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) print_help; exit 0;;
        -f|--file) FILE=$2; shift; shift;;
        -s|--subtitles) SUBTITLES=$2; shift; shift;;
        *) echo "Unvalid parameter: $1"; exit 1;;
    esac
done

cast

exit 0

