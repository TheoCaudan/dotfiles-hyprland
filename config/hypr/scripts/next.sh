#!/usr/bin/env bash

WS=$(hyprctl activeworkspace -j | jq ".id")

if [ "$WS" -ge 5 ]; then
    NEXT=1
else
    NEXT=$((WS + 1))
fi

hyprctl dispatch "hl.dsp.focus({ workspace = \"$NEXT\" })"
