#!/bin/sh

# replace the value with your own touchpad device (list your device using ''hyprctl devices')
HYPRLAND_DEVICE="sppt2600:00-0911:5288-touchpad"

if [ -z "$XDG_RUNTIME_DIR" ]; then
	export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"
export NOTIFICATION_ID="/tmp/notify_id"
export NOTIFICATION_ID2="/tmp/notify_id2"

enable_touchpad() {
	printf "true" >"$STATUS_FILE"

	printf "$(notify-send 'lid sleep ENABLED' -p)" >"$NOTIFICATION_ID"
	printf "$(notify-send '.  Touchpad Enabled  .' -p)" >"$NOTIFICATION_ID2"

	hyprctl keyword "device:$HYPRLAND_DEVICE:enabled" true

	hyprctl reload
	hyprctl --batch "keyword bindl ,switch:on:Lid Switch,exec,systemctl suspend ; keyword bindl ,switch:off:Lid Switch,exec,notify-send '     𝕎 𝕖 𝕝 𝕔 𝕠 𝕞 𝕖  𝔹 𝕒 𝕔 𝕜  𝔾 𝕒 𝕫     ' "
}

disable_touchpad() {
	printf "false" >"$STATUS_FILE"

	notify-send "lid sleep DISABLED" -r "$(cat /tmp/notify_id)"
	notify-send -u normal "Touchpad Disabled" -r "$(cat /tmp/notify_id2)"

	hyprctl keyword "device:$HYPRLAND_DEVICE:enabled" false
	hyprctl reload
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
