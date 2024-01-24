#!/bin/sh
#only works for hyprland

if [ -z "$XDG_RUNTIME_DIR" ]; then
	export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi
export LID_STATUS="$XDG_RUNTIME_DIR/lid_sleep.status"
export NOTIFYID="$XDG_RUNTIME_DIR/lidsleep_notify_id"

get_notification_id() {
	if [ -s "$NOTIFYID" ]; then
		cat $NOTIFYID
	else
		echo 0
	fi
}

nid=$(get_notification_id)

enable_lidsleep() {
	printf "true" >"$LID_STATUS"
	hyprctl reload
	hyprctl --batch "keyword bindl ,switch:on:Lid Switch,exec,systemctl suspend ; keyword bindl ,switch:off:Lid Switch,exec,notify-send '     𝕎 𝕖 𝕝 𝕔 𝕠 𝕞 𝕖  𝔹 𝕒 𝕔 𝕜  𝔾 𝕒 𝕫     ' "
	notify-send -p -r $nid '.   lid sleep   :   ON   .' >$NOTIFYID

}

disable_lidsleep() {
	printf "false" >"$LID_STATUS"

	hyprctl reload
	notify-send -p -r $nid 'lid sleep   :   OFF' >$NOTIFYID
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
