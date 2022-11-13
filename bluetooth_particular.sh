bluetoothctl power on
if bluetoothctl connect 38:8F:30:0A:EE:9D | grep -q "successful" ; 
then 
	notify-send "Bluetooth" "Galaxy Buds Connected..." ; 
else 
	notify-send "Bluetooth" "Failed to connect..." ; 
fi
