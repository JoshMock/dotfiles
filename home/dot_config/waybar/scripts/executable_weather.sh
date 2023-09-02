#!/bin/bash

location='37207'
content_f=$(curl -sS "https://thisdavej.azurewebsites.net/api/weather/current?loc=$location&deg=F")
content_c=$(curl -sS "https://thisdavej.azurewebsites.net/api/weather/current?loc=$location&deg=C")
temp_f="$(echo "$content_f" | jq -r .temperature)"
feelslike_f="$(echo "$content_f" | jq -r .feelslike)"
text="$(echo "$content_f" | jq -r .skytext)"
temp_c="$(echo "$content_c" | jq -r .temperature)"
feelslike_c="$(echo "$content_c" | jq -r .feelslike)"
tooltip="$temp_f°F ($temp_c°C), feels like $feelslike_f°F ($feelslike_c°C)\n$text"
echo "{\"text\": \"$temp_f°F\", \"tooltip\": \"$tooltip\", \"class\": \"\" }"
