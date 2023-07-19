#!/bin/sh

NotificationID_File=/tmp/caffeine_notification_id

function get_notification_id {
  if [ -s "$NotificationID_File" ]; then
    cat $NotificationID_File
  else
    echo 0
  fi
}

nid=$(get_notification_id)

if pgrep -x swayidle.sh > /dev/null; then
	notify-send -p -r $nid ".  Caffeine Enabled  ." > $NotificationID_File
  pkill swayidle
else
	notify-send -p -r $nid "Caffeine Disabled" > $NotificationID_File
  $HOME/scripts/hyprland/swayidle.sh &
fi
