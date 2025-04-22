#!/bin/sh

# Default interval is 10 minutes
: "${POLL_INTERVAL:=600}"

while true; do
  $(which php) /usr/src/app/pollingScript.php
  sleep "$POLL_INTERVAL"
done