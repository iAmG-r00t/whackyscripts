#!/usr/bin/env bash

: '

Source: https://unix.stackexchange.com/a/227222

Script that displays an alert message
... to plug in charger or suspends the
... pc when not plugged in to prevent shutdown

Specific to Lenovo Thinkpad T480; which contains
... two batteries where bat0 (internal)
... drains first then the bat1 (external)
'


BATTERY=$(upower -e | grep 'BAT1')

while true
do
  BATTERY_PERCENTAGE=$(upower -i "$BATTERY" | grep percentage | awk '{ print $2 }'| sed s/'%'/''/g)
  CABLE=$(upower -i /org/freedesktop/UPower/devices/line_power_AC | grep -n2 line-power | grep online | awk '{ print $3 }')

  if [[ "$BATTERY_PERCENTAGE" -lt "10" && $CABLE = "no" ]]; then

    pidof zenity | xargs kill -9
    notify-send --urgency=critical "WARNING: Battery is about to die"  "Suspending PC ...."
    sleep 10
    systemctl suspend
  
  elif [[ "$BATTERY_PERCENTAGE" -lt "20" && $CABLE = "no" ]]; then

    pidof zenity | xargs kill -9
    sleep 5
    zenity --error --text="Battery Low, please charge device\!" --title="Warning"
  
  fi

  sleep 40

done
