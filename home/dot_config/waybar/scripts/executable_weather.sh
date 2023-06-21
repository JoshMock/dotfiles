#!/bin/bash

LOC="$1"
# HTML encode string as %20
LOCATION=$(sed -e "s/ /%20/g" <<<"$LOC")
content=$(curl -sS https://wttr.in/?format=j1)
content=$(curl -sS "https://thisdavej.azurewebsites.net/api/weather/current?loc=$LOCATION&deg=F")
ICON=$(curl -s 'https://wttr.in/?format=1' | sed 's/[+0-9a-cA-Z°-]//g' )
current="$(echo "$content" | jq -r .current_condition)"
TEMP="$(echo "$current" | jq -r .temp_F)"
TOOLTIP=$(echo $current | jq -r '. | "\(.temp_F)°F\nFeels like \(.FeelsLikeF)"' | sed 's/"//g')
echo '{"text": "'$TEMP'", "tooltip": "'$ICON $TOOLTIP $LOC'", "class": '$CLASS' }'
