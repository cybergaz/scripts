systemctl stop warp-svc &&
	systemctl start systemd-resolved &&
	notify-send "warp" "Disconnected"
