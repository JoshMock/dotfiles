#!/usr/bin/bash
if cat /proc/acpi/button/lid/*/state | grep -q open; then
    swaymsg output eDP-1 enable
    swaymsg output DP-2 enable
    swaymsg output LVDS-1 enable
    swaymsg output DP-3 disable
else
    swaymsg output eDP-1 disable
    swaymsg output DP-2 disable
    swaymsg output DP-3 disable
    swaymsg output LVDS-1 disable
fi
