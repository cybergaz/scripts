#!/usr/bin/env bash

EMOJI_FILE="$HOME/scripts/wofi/emoji-db.txt"

awk '
/^[0-9A-F ]+ *; fully-qualified/ {
    split($0, parts, "# ")
    split(parts[2], emoji_parts, " ")
    print emoji_parts[1]
}
' "$EMOJI_FILE" |
  wofi --show dmenu \
    -i \
    -w 12 \
    --conf "$HOME/.config/wofi/config_emoji" \
    -s "$HOME/.config/wofi/style_emoji.css" \
    --normal-window |
  tr -d "\n" |
  wl-copy
