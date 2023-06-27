#!/bin/bash

content=$(curl -sS https://wttr.in/Nashville\?format=j1)
ICON=$(curl -s 'https://wttr.in/Nashville\?format=1' | sed 's/[+0-9a-cA-Z°-]//g' )
current="$(echo "$content" | jq -r '.current_condition[0]')"
TEMP="$(echo "$current" | jq -r .temp_F)"
TOOLTIP=$(echo "$current" | jq -r '. | "\(.temp_F)°F\nFeels like \(.FeelsLikeF)°F"' | sed 's/"//g')
echo "{\"text\": \"$TEMP\", \"tooltip\": \"$ICON $TOOLTIP\", \"class\": \"\" }"
