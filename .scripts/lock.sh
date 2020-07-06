#!/bin/bash

scrot /tmp/lock.png
convert /tmp/lock.png -scale 10% -scale 1000% /tmp/lock.png

i3lock \
-i /tmp/lock.png \
--clock \
--radius=120 \
--datecolor=ffffffff \
--timecolor=ffffffff \
--keyhlcolor=#b6e87599 \
--bshlcolor=#ffc15099 \
--ringcolor=#ffffff11 \
--insidecolor=#ffffff11 \
--linecolor=ffffffff \
--ringvercolor=#ffffff11 \
--insidevercolor=#75d3ff99 \
--verifcolor=#ffffffff \
--ringwrongcolor=#ffffff11 \
--insidewrongcolor=#ff355b99 \
--wrongcolor=#ffffffff

rm /tmp/lock.png

