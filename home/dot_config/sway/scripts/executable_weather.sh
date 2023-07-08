#!/bin/bash

content=$(curl -sS 'https://wttr.in/?format=j1')
current="$(echo "$content" | jq -r '.current_condition[0]')"
TEMP="$(echo "$current" | jq -r .temp_F)"
TOOLTIP=$(echo "$current" | jq -r '. | "\(.temp_F)°F, feels like \(.FeelsLikeF)°F"' | sed 's/"//g')
echo "{\"text\": \"$TEMP°F\", \"tooltip\": \"$TOOLTIP\", \"class\": \"\" }"
