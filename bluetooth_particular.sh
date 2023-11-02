bluetoothctl power on
if bluetoothctl connect 84:0F:2A:31:5F:BA | grep -q "successful"; then
	notify-send "Bluetooth" ". . : :  Air 5 Connected  : : . ."
else
	notify-send "Connection Refused"
fi
