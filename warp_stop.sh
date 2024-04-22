sudo systemctl stop warp-svc &&
	sudo systemctl start systemd-resolved &&
	notify-send "warp" "Disconnected"
