#!/bin/bash

if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi
export NOTIFYID="$XDG_RUNTIME_DIR/caffeine_notify_id"

function get_notification_id {
    if [ -s "$NOTIFYID" ]; then
        cat $NOTIFYID
    else
        echo 0
    fi
}

nid=$(get_notification_id)

if pgrep -x swayidle.sh >/dev/null; then
    notify-send -p -r $nid ".  Caffeine Enabled  ." >$NOTIFYID
    pkill swayidle
else
    notify-send -p -r $nid "Caffeine Disabled" >$NOTIFYID
    $HOME/scripts/hyprland/swayidle.sh &
fi
