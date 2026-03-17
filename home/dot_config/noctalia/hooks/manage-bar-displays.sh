#!/usr/bin/env bash
# Manage noctalia bar visibility based on monitor connections
# Show bar on eDP-1 only if DP-3 is disconnected

set -euo pipefail

CONFIG_FILE="${HOME}/.config/noctalia/settings.json"
TEMP_FILE="${CONFIG_FILE}.tmp"

# Check if displays are connected using xrandr or wayland tools
check_displays() {
    if command -v wlr-randr &>/dev/null; then
        # Wayland
        local displays=$(wlr-randr | grep -E '^\w+' | awk '{print $1}')
    else
        # X11 fallback
        local displays=$(xrandr --query | grep ' connected' | awk '{print $1}')
    fi
    echo "$displays"
}

# Check if a specific display is connected
is_connected() {
    local display="$1"
    local displays
    displays=$(check_displays)
    echo "$displays" | grep -q "^${display}$"
}

# Update the bar configuration
update_bar_config() {
    local monitors="$1"
    local display_mode="$2"

    # Use jq to update the configuration if available
    if command -v jq &>/dev/null; then
        jq --arg monitors "$monitors" --arg mode "$display_mode" \
            '.bar.monitors = ($monitors | split(",")) | .bar.displayMode = $mode' \
            "$CONFIG_FILE" > "$TEMP_FILE" && mv "$TEMP_FILE" "$CONFIG_FILE"
    else
        # Fallback: simple sed-based replacement (less reliable)
        sed -i "s/\"displayMode\": \"[^\"]*\"/\"displayMode\": \"$display_mode\"/" "$CONFIG_FILE"
    fi
}

# Main logic
if is_connected "DP-3"; then
    # DP-3 is connected, hide the bar
    update_bar_config "" "never"
else
    # DP-3 is not connected, show bar on eDP-1
    update_bar_config "eDP-1" "always_visible"
fi
