#!/usr/bin/env bash
#
# calendar-notifier.sh
#
# Designed to run from cron or a systemd timer (e.g. every 5–15 minutes).
# Fetches Google Calendar events starting within the next hour that you've
# accepted or tentatively accepted, and posts/updates desktop notifications.
#
# - Replaces existing notifications for the same event (no duplicates)
# - Clicking a notification opens the Zoom link or Google Calendar page
# - Background action-handler processes survive after the script exits
#
# Usage:
#   */5 * * * *  DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /path/to/calendar-notifier.sh

set -euo pipefail

CALENDAR="joshua.mock@elastic.co"
LOOKAHEAD_SECS=3600  # notify for events starting within the next hour
STATE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/calendar-notifier"
mkdir -p "$STATE_DIR"

# xdg-open (via gio/gvfs) needs XDG_RUNTIME_DIR to reach the session D-Bus.
# cron doesn't set it, so derive it from the UID if missing.
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

NOW_ISO=$(date --iso-8601=seconds)
NOW_EPOCH=$(date +%s)
HORIZON_ISO=$(date -d "+${LOOKAHEAD_SECS} seconds" --iso-8601=seconds)

# fetch events from now through the lookahead window
EVENTS_JSON=$(gws calendar events list \
  --params "{\"calendarId\":\"${CALENDAR}\",\"timeMin\":\"${NOW_ISO}\",\"timeMax\":\"${HORIZON_ISO}\",\"singleEvents\":true,\"orderBy\":\"startTime\"}" \
  --format json 2>/dev/null)

# filter to accepted/tentative, extract fields including stable event id
JQ_FILTER=$(cat <<'JQEOF'
[.items[] |
  (.attendees // [] | map(select(.self == true)) | first // null) as $me |
  (if (.attendees | length) == 0 then "accepted"
   elif $me then $me.responseStatus
   else "declined" end) as $status |
  select($status == "accepted" or $status == "tentative") |
  {
    id,
    summary,
    start: .start.dateTime,
    end:   .end.dateTime,
    status: $status,
    htmlLink,
    location: (.location // ""),
    zoom: (
      (.description // "") as $desc |
      (.location // "") as $loc |
      ($loc | capture("(?<url>https://[^ \"<]*zoom[.]us/j/[^ \"<]*)") // null) as $loc_zoom |
      ($desc | capture("(?<url>https://[^ \"<]*zoom[.]us/j/[^ \"<]*)") // null) as $desc_zoom |
      if $loc_zoom then $loc_zoom.url
      elif $desc_zoom then $desc_zoom.url
      else null
      end
    )
  }
]
JQEOF
)

FILTERED=$(echo "$EVENTS_JSON" | jq "$JQ_FILTER")
EVENT_COUNT=$(echo "$FILTERED" | jq 'length')

# track which event hashes are active this run (for cleanup)
ACTIVE_HASHES=()

for i in $(seq 0 $((EVENT_COUNT - 1))); do
  EVENT=$(echo "$FILTERED" | jq ".[$i]")
  EVENT_ID=$(echo "$EVENT" | jq -r '.id')
  SUMMARY=$(echo "$EVENT" | jq -r '.summary')
  START=$(echo "$EVENT" | jq -r '.start')
  END=$(echo "$EVENT" | jq -r '.end')
  STATUS=$(echo "$EVENT" | jq -r '.status')
  ZOOM=$(echo "$EVENT" | jq -r '.zoom // empty')
  HTML_LINK=$(echo "$EVENT" | jq -r '.htmlLink')

  START_EPOCH=$(date -d "$START" +%s)
  END_EPOCH=$(date -d "$END" +%s)
  START_HUMAN=$(date -d "$START" '+%-l:%M %p')
  END_HUMAN=$(date -d "$END" '+%-l:%M %p')

  # stable hash for state file names (based on calendar event id)
  HASH=$(echo -n "$EVENT_ID" | md5sum | cut -c1-12)
  ACTIVE_HASHES+=("$HASH")

  NID_FILE="$STATE_DIR/${HASH}.nid"
  PID_FILE="$STATE_DIR/${HASH}.pid"
  URL_FILE="$STATE_DIR/${HASH}.url"
  LAST_FILE="$STATE_DIR/${HASH}.last"

  # determine open URL
  if [[ -n "$ZOOM" ]]; then
    OPEN_URL="$ZOOM"
    ACTION_LABEL="Open Zoom"
  else
    OPEN_URL="$HTML_LINK"
    ACTION_LABEL="Open in Calendar"
  fi

  # time until meeting starts
  SECS_UNTIL=$(( START_EPOCH - NOW_EPOCH ))

  # skip meetings that started more than 10 minutes ago
  if [[ $SECS_UNTIL -lt -600 ]]; then
    continue
  fi

  # graduated cooldown: alert less frequently the further away the event is
  #   in progress  → every 30 min (one alert at start, then quiet)
  #   < 5 min      → every run
  #   5–15 min     → every 5 min
  #   15–30 min    → every 15 min
  #   > 30 min     → every 30 min
  if [[ $SECS_UNTIL -le 0 ]]; then
    COOLDOWN=1800
  elif [[ $SECS_UNTIL -lt 300 ]]; then
    COOLDOWN=0
  elif [[ $SECS_UNTIL -lt 900 ]]; then
    COOLDOWN=300
  elif [[ $SECS_UNTIL -lt 1800 ]]; then
    COOLDOWN=900
  else
    COOLDOWN=1800
  fi

  if [[ -f "$LAST_FILE" && $COOLDOWN -gt 0 ]]; then
    LAST_NOTIFIED=$(cat "$LAST_FILE")
    if (( NOW_EPOCH - LAST_NOTIFIED < COOLDOWN )); then
      continue
    fi
  fi

  # build notification body
  if [[ $SECS_UNTIL -le 0 ]]; then
    BODY="Now until ${END_HUMAN}"
  elif [[ $SECS_UNTIL -lt 60 ]]; then
    BODY="Starting in less than a minute (${START_HUMAN})"
  elif [[ $SECS_UNTIL -lt 3600 ]]; then
    MINS=$(( SECS_UNTIL / 60 ))
    BODY="Starting in ${MINS} min (${START_HUMAN} – ${END_HUMAN})"
  else
    BODY="${START_HUMAN} – ${END_HUMAN}"
  fi

  if [[ "$STATUS" == "tentative" ]]; then
    BODY="${BODY}  ·  RSVP: maybe"
  fi

  # expiration: keep notification alive until the meeting ends
  EXPIRE_MS=$(( (END_EPOCH - NOW_EPOCH) * 1000 ))
  if [[ $EXPIRE_MS -lt 30000 ]]; then
    EXPIRE_MS=30000
  fi

  # kill any existing action-handler process for this event
  if [[ -f "$PID_FILE" ]]; then
    OLD_PID=$(cat "$PID_FILE")
    kill "$OLD_PID" 2>/dev/null || true
    rm -f "$PID_FILE"
  fi

  # build notify-send args
  NOTIFY_ARGS=(
    --app-name="Calendar"
    --icon=x-office-calendar
    --urgency=normal
    --expire-time="$EXPIRE_MS"
    --action="open=${ACTION_LABEL}"
    --print-id
    --wait
  )

  # replace existing notification if we have a saved ID
  if [[ -f "$NID_FILE" ]]; then
    NOTIFY_ARGS+=(--replace-id="$(cat "$NID_FILE")")
  fi

  # save the URL so the background handler can read it
  echo "$OPEN_URL" > "$URL_FILE"

  # launch notification + action handler in a detached background process
  (
    SEEN_ID=""
    while IFS= read -r line; do
      if [[ -z "$SEEN_ID" ]]; then
        # first line: notification ID
        echo "$line" > "$NID_FILE"
        SEEN_ID=1
      else
        # after --wait resolves: action name
        if [[ "$line" == "open" ]]; then
          URL=$(cat "$URL_FILE" 2>/dev/null || true)
          if [[ -n "$URL" ]]; then
            logger -t calendar-notifier "Opening URL: $URL"
            setsid xdg-open "$URL" </dev/null &>/dev/null &
          fi
        fi
      fi
    done < <(notify-send "${NOTIFY_ARGS[@]}" \
      "📅 ${SUMMARY}" \
      "$BODY" 2>/dev/null || true)
  ) &
  HANDLER_PID=$!
  echo "$HANDLER_PID" > "$PID_FILE"

  # brief pause to let notify-send flush the ID before next iteration
  # (so --replace-id is available if the same event somehow appears twice)
  sleep 0.2

  disown "$HANDLER_PID" 2>/dev/null || true

  logger -t calendar-notifier "Notification for '${SUMMARY}' at ${START_HUMAN} (hash=${HASH})"
  echo "$NOW_EPOCH" > "$LAST_FILE"
done

# clean up state files for events no longer in the window
for nid_file in "$STATE_DIR"/*.nid; do
  [[ -f "$nid_file" ]] || continue
  HASH=$(basename "$nid_file" .nid)

  FOUND=0
  for active in "${ACTIVE_HASHES[@]+"${ACTIVE_HASHES[@]}"}"; do
    if [[ "$active" == "$HASH" ]]; then
      FOUND=1
      break
    fi
  done

  if [[ $FOUND -eq 0 ]]; then
    # kill orphaned handler
    if [[ -f "$STATE_DIR/${HASH}.pid" ]]; then
      kill "$(cat "$STATE_DIR/${HASH}.pid")" 2>/dev/null || true
    fi
    rm -f "$STATE_DIR/${HASH}".{nid,pid,url,last}
  fi
done
