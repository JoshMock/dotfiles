#!/usr/bin/env bash
# Monitor display hotplug events and update noctalia bar accordingly

set -euo pipefail

CONFIG_FILE="${HOME}/.config/noctalia/settings.json"
LOCK_FILE="/tmp/noctalia-monitor-manager.lock"

# Logging
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >> "${HOME}/.local/share/noctalia/monitor-manager.log"
}

# Check if displays are connected
check_displays() {
    if command -v wlr-randr &>/dev/null; then
        # Wayland
        wlr-randr | grep -E '^\w+' | awk '{print $1}' | sort
    else
        # X11 fallback
        xrandr --query | grep ' connected' | awk '{print $1}' | sort
    fi
}

# Check if a specific display is connected
is_connected() {
    local display="$1"
    check_displays | grep -q "^${display}$"
}

# Update the bar configuration with debouncing
update_bar_config() {
    local monitors="$1"
    local display_mode="$2"
    
    # Prevent rapid successive updates
    if [ -f "$LOCK_FILE" ]; then
        local lock_age=$(($(date +%s) - $(stat -c %Y "$LOCK_FILE")))
        if [ "$lock_age" -lt 2 ]; then
            log "Skipping update - debouncing (lock age: ${lock_age}s)"
            return
        fi
    fi
    
    touch "$LOCK_FILE"
    
    log "Updating bar configuration - monitors: [$monitors], mode: $display_mode"
    
    if command -v jq &>/dev/null; then
        if jq --arg monitors "$monitors" --arg mode "$display_mode" \
            '.bar.monitors = ($monitors | split(",")) | .bar.displayMode = $mode' \
            "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"; then
            log "Configuration updated successfully"
            # Signal noctalia to reload
            if command -v dbus-send &>/dev/null; then
                dbus-send --session --print-reply /com/github/Aylur/Noctalia com.github.Aylur.Noctalia.Reload 2>/dev/null || true
            fi
        else
            log "ERROR: Failed to update configuration"
        fi
    else
        log "ERROR: jq not found, cannot update configuration"
    fi
}

# Main monitoring loop
monitor_hotplug_events() {
    log "Starting monitor hotplug listener"
    
    # Initial state
    local prev_dp3_connected=$(is_connected "DP-3" && echo "true" || echo "false")
    log "Initial state - DP-3 connected: $prev_dp3_connected"
    
    # Use udevadm to monitor hotplug events
    udevadm monitor --udev --subsystem-match=drm --property 2>/dev/null | \
    while IFS= read -r line; do
        if [[ "$line" =~ ^DEVPATH= ]]; then
            # Small delay to allow udev to fully process the change
            sleep 0.5
            
            local dp3_connected=$(is_connected "DP-3" && echo "true" || echo "false")
            
            if [ "$dp3_connected" != "$prev_dp3_connected" ]; then
                log "Monitor state change detected - DP-3 connected: $dp3_connected"
                
                if [ "$dp3_connected" = "true" ]; then
                    log "DP-3 connected - moving bar to external monitor"
                    update_bar_config "DP-3" "always_visible"
                else
                    log "DP-3 disconnected - moving bar to laptop monitor"
                    update_bar_config "eDP-1" "always_visible"
                fi
                
                prev_dp3_connected="$dp3_connected"
            fi
        fi
    done
}

# Trap signals for graceful shutdown
cleanup() {
    log "Shutting down monitor hotplug listener"
    rm -f "$LOCK_FILE"
    exit 0
}

trap cleanup SIGTERM SIGINT

# Create log directory
mkdir -p "${HOME}/.local/share/noctalia"

# Start monitoring
monitor_hotplug_events
