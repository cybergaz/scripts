systemctl start NetworkManager warp-svc
warp-cli connect
sleep 1
systemctl stop systemd-resolved.service
sleep 2
notify-send "warp" "$(warp-cli status)"
