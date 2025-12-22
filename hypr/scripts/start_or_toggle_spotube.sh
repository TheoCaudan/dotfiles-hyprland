#!/bin/sh

if playerctl status >/dev/null 2>&1; then
  playerctl play-pause
else
  spotube &
fi
