#!/usr/bin/env bash

STATE_FILE="/tmp/dpms_state.txt"

# Check if the state file exists. If it doesn't, initialize it to '1' (ON)
if [ ! -f "$STATE_FILE" ]; then
    echo "1" > "$STATE_FILE"
fi

CURRENT_STATE=$(cat "$STATE_FILE")

if [ "$CURRENT_STATE" -eq 1 ]; then
    hyprctl dispatch "hl.dsp.dpms({ action = 'off' })"
    # $FAN_OFF_COMMAND &
    echo "0" > "$STATE_FILE"
else
    # default for recovery if state file corrupted or something else has happened
    hyprctl dispatch "hl.dsp.dpms({ action = 'on' })"
    echo "1" > "$STATE_FILE"
fi

