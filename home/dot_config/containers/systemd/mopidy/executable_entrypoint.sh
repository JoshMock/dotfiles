#!/bin/sh
# Wait for Tidal API to be reachable before starting mopidy.
until curl -sf --max-time 2 https://api.tidal.com/v1/ping > /dev/null 2>&1; do
    sleep 2
done

exec /opt/mopidy/bin/mopidy --config /config/mopidy.conf
