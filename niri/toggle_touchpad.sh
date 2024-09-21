sed -i '/touchpad {/,/}/ {/^\s*\/\/\s*off/s/^    \/\/ //;t; /^\s*off/s/^/    \/\/ /}' $HOME/.config/niri/config.kdl
notify-send "Touchpad Toggle"
