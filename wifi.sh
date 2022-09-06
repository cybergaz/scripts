#!/bin/bash

bssid=$(nmcli device wifi list | sed -n '1!p' | cut -v 9- | wofi --show dmenu -p "Select wifi :" -l 20 | cut -d' ' -f1)
pass=$(echo "" | wofi --show dmenu -p "Enter Password : ")

nmcli device wifi connect $bssid password $pass
