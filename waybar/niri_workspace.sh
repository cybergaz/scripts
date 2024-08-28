workspaces=$(niri msg --json workspaces)

for workspace in $(echo "${workspaces}" | jq -c '.[]'); do
    # echo $(echo "$workspace" | jq -r '.is_active')
    if [[ $(echo "$workspace" | jq -r '.is_active') == 'true' ]]; then
        cw="$(echo "$workspace" | jq -r '.idx')"
    fi
done

echo '{ "text": "'$cw'", "class":"custom-workspaces","alt":"0" }'
