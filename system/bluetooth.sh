#!/bin/bash
bluetoothctl power on
bluetoothctl scan on &
sleep 1
bluetoothctl connect $(bluetoothctl devices | wofi --show dmenu | cut -b 8-24) &&
  # notify-send "Bluetooth" ". . : :  Connected  : : . ." &&
  notify-send -i bluetooth-active "Bluetooth" "Connected" &&
  exit
# notify-send "Bluetooth" ". . : :  Failed to connect  : : . ."
notify-send -i bluetooth-offline "Bluetooth" "Failed to connect"
sleep 5
pkill bluetoothctl
