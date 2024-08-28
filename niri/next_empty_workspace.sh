workspaces=$(niri msg --json workspaces)

last_entry=$(echo "$workspaces" | jq '.[-1]')

niri msg action focus-workspace $(echo "$last_entry" | jq -r '.idx')
