#!/bin/sh

WS=$(hyprctl activeworkspace -j | jq ".id")

if [ "$WS" -le 1 ]; then
  PREV=5
else
  PREV=$((WS - 1))
fi

hyprctl dispatch "hl.dsp.focus({ workspace = \"$PREV\" })"
