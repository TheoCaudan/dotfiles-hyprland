#!/bin/sh

WS=$(hyprctl activeworkspace -j | jq ".id")

if [ "$WS" -le 1]; then
    hyprctl dispatch workspace 5
else
    hyprctl dispatch workspace $((WS - 1))
fi
