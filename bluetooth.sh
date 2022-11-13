#!/bin/bash
bluetoothctl power on
bluetoothctl scan on &
sleep 1
if bluetoothctl connect $(bluetoothctl devices | wofi --show dmenu | cut -b 8-24) | grep -q "successful" ;
then 
	notify-send "Bluetooth" "Connected......" ; 
else 
	notify-send "Bluetooth" "Failed to connect..." ; 
fi
sleep 5
pkill bluetoothctl
