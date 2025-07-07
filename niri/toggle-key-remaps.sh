#!/bin/bash

CONFIG_FILE="$HOME/.config/niri/config.kdl"

# Patterns to match
# Escape the actual content without caring about indentation
PATTERN1='options "caps:escape,altwin:swap_lalt_lwin,ctrl:swap_ralt_rctl"'
PATTERN2='options "caps:escape"'

# If PATTERN1 is uncommented
if grep -q '^[[:space:]]*'"$PATTERN1"'$' "$CONFIG_FILE"; then
  sed -i \
    -e 's/^\([[:space:]]*\)'"$PATTERN1"'$/\1\/\/ '"$PATTERN1"'/' \
    -e 's/^\([[:space:]]*\)\/\/ '"$PATTERN2"'$/\1'"$PATTERN2"'/' \
    "$CONFIG_FILE"

# If PATTERN2 is uncommented
elif grep -q '^[[:space:]]*'"$PATTERN2"'$' "$CONFIG_FILE"; then
  sed -i \
    -e 's/^\([[:space:]]*\)'"$PATTERN2"'$/\1\/\/ '"$PATTERN2"'/' \
    -e 's/^\([[:space:]]*\)\/\/ '"$PATTERN1"'$/\1'"$PATTERN1"'/' \
    "$CONFIG_FILE"
else
  echo "No matching uncommented lines found to toggle."
fi
