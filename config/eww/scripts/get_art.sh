#!/bin/bash

CACHE_DIR="/tmp/eww/media"
mkdir -p "$CACHE_DIR"

ART_URL=$(playerctl metadata mpris:artUrl 2>/dev/null)

if [ -z "$ART_URL" ]; then

  echo "$HOME/.config/waybar/scripts/default_cover.png"
  exit 0
fi

if [[ "$ART_URL" == file://* ]]; then

  echo "${ART_URL#file://}"
else

  FILENAME=$(echo "$ART_URL" | md5sum | cut -d' ' -f1)
  if [ ! -f "$CACHE_DIR/$FILENAME" ]; then
    curl -s "$ART_URL" -o "$CACHE_DIR/$FILENAME"
  fi
  echo "$CACHE_DIR/$FILENAME"
fi
