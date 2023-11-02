#!/bin/sh
echo
echo "#    #               # ## # "
echo "#    #                 #    "
echo "#### #### #### # # # # ## # "
echo "#  # #  # #  # # # # # #  # "
echo "#### #### #### ##### # #  # "
echo "             #              "
echo "             #              "
echo "........................... "
echo
CONF=/etc/wpa_supplicant.conf
if (pgrep dhclient) >/dev/null 2>&1; then
	kill "$(pgrep dhclient)"
fi
if (pgrep wpa_supplicant) >/dev/null 2>&1; then
	kill "$(pgrep wpa_supplicant)"
fi
echo "Available devices:"
echo
ip link | awk '/</ {print $2 | "tr -d :"}'
echo
printf "Interface: "
read FACE
ip link set "$FACE" down >/dev/null 2>&1
if [ $? -eq 1 ]; then
	echo
	echo "Device '$FACE' not found, exiting..."
	echo
	exit
fi
ip link set "$FACE" up
echo
if [ -e /etc/wpa_supplicant.conf ]; then
	echo "Previous configuration found:"
	echo
	awk '/"/' /etc/wpa_supplicant.conf
	echo
	printf "Use the above (y/n)? "
	read ANSWER
	echo
	if echo "$ANSWER" | grep -iq "^y"; then
		wpa_supplicant -i "$FACE" -B -Dwext,nl80211 -c "$CONF" >/dev/null 2>&1
		dhclient "$FACE" >/dev/null 2>&1
		exit
	fi
fi
echo "Scanning for networks..."
iwlist "$FACE" scan | awk -F '"' '/ESSID/ {print $2 | "sort -u"}' 2>/dev/null
echo
printf "Network: "
read NAME
iwconfig "$FACE" essid "$NAME" >/dev/null 2>&1
echo
stty -echo
printf "Password: "
read PASS
stty echo
echo
if [ -z "$PASSWORD" ]; then
	ip link set "$FACE" up
	echo "Connecting to the network..."
	echo
	iwconfig "$FACE" essid "$NAME" >/dev/null 2>&1
	dhclient "$FACE" >/dev/null 2>&1
	exit
fi
echo
echo "Writing configuration file..."
cat <<EOT >"$CONF"
# WPA-PSK/TKIP
update_config=1
ctrl_interface=/var/run/wpa_supplicant
 
network={
   ssid="$NAME"
   psk="$PASS"
}
EOT
echo "Starting wpa_supplicant..."
wpa_supplicant -i "$FACE" -B -Dwext,nl80211 -c "$CONF" >/dev/null 2>&1
echo "Connecting to the network..."
echo
dhclient "$FACE" >/dev/null 2>&1
exit
