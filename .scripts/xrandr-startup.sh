#!/bin/bash

MONITORS=$(xrandr -q | grep " connected" | wc -l)

if [ $MONITORS = 3 ]; then
    xrandr --output eDP-1 --off --output DP-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal 
elif [ $MONITORS = 2 ]; then
    xrandr --output eDP-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off
fi

