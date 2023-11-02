systemctl start systemd-resolved
systemctl stop NetworkManager warp-svc.service
sleep 1
notify-send "warp" "Disconnected"
iwgtk
