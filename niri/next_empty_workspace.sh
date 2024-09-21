# workspaces=$(niri msg --json workspaces)
# echo $workspaces
#
# last_entry=$(echo "$workspaces" | jq '.[-1]')
# echo $last_entry

# niri msg action focus-workspace $(echo "$last_entry" | jq -r '.idx')
niri msg action focus-workspace $(niri msg workspaces | tail -n 1 | tr -d " \t")
