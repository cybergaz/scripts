rm -rf /tmp/cliphist
cliphist list | wofi --show dmenu --conf $HOME/.config/wofi/config_clip -s $HOME/.config/wofi/style_clipboard.css --normal-window >/tmp/cliphist
if [ -s /tmp/cliphist ]; then
	cliphist decode </tmp/cliphist | wl-copy
else
	exit 0
fi
