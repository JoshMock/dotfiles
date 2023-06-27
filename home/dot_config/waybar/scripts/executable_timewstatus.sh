#!/usr/bin/env bash

OUTPUT=$(timew get dom.active.json 2> /dev/null)
RESULT=$?

if [ $RESULT -eq 0 ]; then
  FINAL=$(echo "$OUTPUT" | jq -r '.tags | join(", ")')
else
  FINAL='n/a'
fi

DAILY_TOTAL=$(timew day | grep Tracked | awk '{print $2}')
WEEKLY_TOTAL=$(timew week | grep Tracked | awk '{print $2}')

echo "$FINAL | $DAILY_TOTAL | $WEEKLY_TOTAL"
