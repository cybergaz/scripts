systemctl start systemd-resolved
systemctl stop NetworkManager warp-svc.service
sleep 1
notify-send "warp" "Disconnected"
iwctl device wlan0 set-property Powered on
