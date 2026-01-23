oklch-color-picker $(niri msg pick-color | tail -n 1 | awk '{print $2}') | tr -d '[:space:]' | wl-copy
