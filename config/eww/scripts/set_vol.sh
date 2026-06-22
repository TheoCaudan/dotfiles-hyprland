#!/bin/bash

VOLUME=$1

DECIMAL_VOLUME=$(echo "scale=2; $VOLUME / 100" | bc -l)

playerctl volume "$DECIMAL_VOLUME" 2>/dev/null
