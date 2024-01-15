#!/bin/sh

HYPRLAND_DEVICE=$(hyprctl devices | grep touchpad | sed 's/^[ \t]*//')

if [ -z "$XDG_RUNTIME_DIR" ]; then
	export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi
export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

enable_touchpad() {
	printf "true" >"$STATUS_FILE"

	# printf "$(notify-send '.  Touchpad Enabled  .' -p)" >"$NOTIFICATION_ID2"
	notify-send '.  Touchpad Enabled  .'

	hyprctl keyword "device:$HYPRLAND_DEVICE:enabled" true
}

disable_touchpad() {
	printf "false" >"$STATUS_FILE"

	notify-send -u normal "Touchpad Disabled"

	hyprctl keyword "device:$HYPRLAND_DEVICE:enabled" false
}

if ! [ -f "$STATUS_FILE" ]; then
	enable_touchpad
else
	if [ $(cat "$STATUS_FILE") = "true" ]; then
		disable_touchpad
	elif [ $(cat "$STATUS_FILE") = "false" ]; then
		enable_touchpad
	fi
fi
