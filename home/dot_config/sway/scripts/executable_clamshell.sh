#!/usr/bin/bash
if cat /proc/acpi/button/lid/*/state | grep -q open; then
    swaymsg output eDP-1 enable
    swaymsg output DP-2 enable
else
    swaymsg output eDP-1 disable
    swaymsg output DP-2 disable
fi
