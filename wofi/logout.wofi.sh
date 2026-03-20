string=$(sed '1,/^### DATA ###$/d' $0 | cut -d= -f1 | wofi --show dmenu --sort-order alphabetical --conf ~/.config/wofi/config_logout -s ~/.config/wofi/style_hz.css --normal-window) &&
  sed '1,/^### DATA ###$/d' $0 | grep "$string=" | sed 's/.*'"$string"'="\([^"]*\)".*/\1/' | sh
exit
### DATA ###
⏻ poweroff="systemctl poweroff"
↺ reboot="systemctl reboot"
⏾ sleep="systemctl suspend"
🗝 lock="hyprlock"
☕︎ caffeine="$HOME/scripts/hyprland/hypridle_caffeine.sh"
