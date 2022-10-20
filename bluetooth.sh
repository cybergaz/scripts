#!/bin/bash

if bluetoothctl connect $(bluetoothctl devices | wofi --show dmenu | cut -b 8-24) | grep -q "successful" ;
then 
	notify-send "Bluetooth" "Connected......" ; 
else 
	notify-send "Bluetooth" "Failed to connect..." ; 
fi
