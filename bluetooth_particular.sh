bluetoothctl power on
if bluetoothctl connect 74:D7:13:00:D6:8B | grep -q "successful" ; 
then 
	notify-send "Bluetooth" ". . : :  Air 3 Connected  : : . ." ; 
else 
	notify-send "Connection Refused" "..:: you have done something wrong ::.." ; 
fi
