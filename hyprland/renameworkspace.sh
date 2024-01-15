current_name=$(hyprctl activeworkspace | head -n 1 | awk '{print $3}')
new_name=$(wofi -d -l 1 -W 350 -H 10 -s $HOME/.config/wofi/style_input.css) &&
	hyprctl dispatch renameworkspace $current_name $new_name &&
	notify-send "workspace    $current_name     ->    $new_name "
