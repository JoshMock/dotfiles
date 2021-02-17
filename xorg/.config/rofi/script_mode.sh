#!/bin/bash

WORKINGDIR="$HOME/.config/rofi/"
MAP="$WORKINGDIR/cmd.csv"

cat "$MAP" \
    | cut -d ',' -f 1 \
    | rofi -dmenu -p "Util " -show combi -modi combi \
    | head -n 1 \
    | xargs -i --no-run-if-empty grep "{}" "$MAP" \
    | cut -d ',' -f 2 \
    | head -n 1 \
    | xargs -i --no-run-if-empty /bin/bash -c "{}"

exit 0
