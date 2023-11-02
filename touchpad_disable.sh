#!/bin/sh

# replace the value with your own touchpad device (list your device using ''hyprctl devices')
HYPRLAND_DEVICE="sppt2600:00-0911:5288-touchpad"

if [ -z "$XDG_RUNTIME_DIR" ]; then
	export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

printf "false" >"$STATUS_FILE"

notify-send -u normal ". Touchpad Disabled ."

hyprctl keyword "device:$HYPRLAND_DEVICE:enabled" false
