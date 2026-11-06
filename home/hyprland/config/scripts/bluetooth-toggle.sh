#!/usr/bin/env bash

rfkill toggle bluetooth

if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
    notify-send "Bluetooth OFF"
else
    notify-send "Bluetooth ON"
fi
