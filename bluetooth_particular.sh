bluetoothctl power on
bluetoothctl connect 84:0F:2A:31:5F:BA &&
	notify-send "Bluetooth" ". . : :  Air 5 Connected  : : . ." &&

	#----------------------------------------------------------------------
	# the steps in this box are exceptional to my buds , a bug you can say that's why i* have to perform it
	pactl set-card-profile bluez_card.84_0F_2A_31_5F_BA a2dp-sink-sbc &&
	pactl set-card-profile bluez_card.84_0F_2A_31_5F_BA a2dp-sink &&
	#----------------------------------------------------------------------
	exit
notify-send "Connection Refused"
