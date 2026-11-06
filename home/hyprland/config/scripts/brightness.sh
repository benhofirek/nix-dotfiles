#!/usr/bin/env bash

direction="$1"
case "$direction" in
  up)   sign="+" ;;
  down) sign="-" ;;
  *) echo "Usage: ${0##*/} up|down" >&2; exit 1 ;;
esac

# brightnessctl -m prints: device,class,current,percent,max
IFS=, read -r _ _ cur _ max < <(brightnessctl -m)

# step = ceil(5% of current), clamped to 1..5
step=$(( (cur * 5 + max - 1) / max ))
(( step < 1 )) && step=1
(( step > 5 )) && step=5

if [[ $direction == down ]]; then
  # -n1 stops brightness from reaching 0 (screen fully off)
  brightnessctl -n1 set "${step}%${sign}"
else
  brightnessctl set "${step}%${sign}"
fi
