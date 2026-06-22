#!/bin/sh

WS=$(hyprctl activeworkspace -j | jq ".id")

if [ "$WS" -ge 5 ]; then
    hyprctl dispatch workspace 1
else
    hyprctl dispatch workspace $((WS + 1))
fi
