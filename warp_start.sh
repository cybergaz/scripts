sudo systemctl start warp-svc &&
    sleep 5 &&
    sudo systemctl stop systemd-resolved.service &&
    warp-cli connect &&
    sleep 2 &&
    notify-send "warp" "$(warp-cli status)" &&
    sleep 5 &&
    notify-send "warp" "$(warp-cli status)"
