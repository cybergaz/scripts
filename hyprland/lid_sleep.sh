#!/bin/sh
#only works for hyprland

export LID_STATUS="/tmp/lid_sleep.status"

enable_lidsleep() {
	printf "true" >"$LID_STATUS"

	hyprctl reload
	hyprctl --batch "keyword bindl ,switch:on:Lid Switch,exec,systemctl suspend ; keyword bindl ,switch:off:Lid Switch,exec,notify-send '     𝕎 𝕖 𝕝 𝕔 𝕠 𝕞 𝕖  𝔹 𝕒 𝕔 𝕜  𝔾 𝕒 𝕫     ' "
	notify-send '.   lid sleep   :   ON   .'

}

disable_lidsleep() {
	printf "false" >"$LID_STATUS"

	hyprctl reload
	notify-send 'lid sleep   :   OFF'
}

if ! [ -f "$LID_STATUS" ]; then
	enable_lidsleep
else
	if [ $(cat "$LID_STATUS") = "true" ]; then
		disable_lidsleep
	elif [ $(cat "$LID_STATUS") = "false" ]; then
		enable_lidsleep
	fi
fi
