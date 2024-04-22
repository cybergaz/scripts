#!/bin/sh

if [ -z "$XDG_RUNTIME_DIR" ]; then
	export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi
export NOTIFYID="$XDG_RUNTIME_DIR/caffeine_notify_id"
export STATUS="$XDG_RUNTIME_DIR/caffeine_status"

function get_notification_id {
  if [ -s "$NOTIFYID" ]; then
    cat $NOTIFYID
  else
    echo 0
  fi
}

nid=$(get_notification_id)

if ! [ -f $STATUS ]; then
	printf "false" >"$STATUS"
fi

if [ $(cat $STATUS) = "false" ]; then
  notify-send -p -r $nid ".  Caffeine Enabled  ." > $NOTIFYID
  echo "true" > $STATUS
  pkill hypridle
else
  notify-send -p -r $nid "Caffeine Disabled" > $NOTIFYID
  echo "false" > $STATUS
  hypridle &
fi
