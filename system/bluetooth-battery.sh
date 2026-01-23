notify-send "Bluetooth Battery" "$(bluetoothctl info | grep 'Name:' | cut -b 8-)   ->   $(bluetoothctl info | grep 'Battery' | sed 's/.*(\([0-9]\+\))/\1/') % "
