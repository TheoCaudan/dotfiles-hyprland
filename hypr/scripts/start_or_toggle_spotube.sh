#!/bin/sh

playerctl status 2>/dev/null 1>&2

if [ $? -eq 0 ]; then
    playerctl play-pause
else
    spotube &
fi
