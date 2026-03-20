#!/bin/sh

# Get reachable IPs
IPS=$(ip neighbour | grep "REACHABLE" | awk '$1 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {print $1}')

# Create menu with custom options at top
MENU="Insert host ID by yourself\nInsert IP address by yourself"
[ -n "$IPS" ] && MENU="$MENU\n$IPS"

# Show wofi menu
SELECTION=$(printf "%b" "$MENU" | wofi --dmenu --prompt "Select IP" 2>/dev/null)
[ -z "$SELECTION" ] && exit 0

# Handle selection
case "$SELECTION" in
"Insert host ID by yourself")
  # Get first reachable IP and extract network prefix
  FIRST_IP=$(printf "%s\n" "$IPS" | head -n 1)
  if [ -z "$FIRST_IP" ]; then
    printf "No reachable neighbours found\n"
    exit 1
  fi
  NETWORK_PREFIX=$(printf "%s" "$FIRST_IP" | cut -d'.' -f1-3)
  printf "Enter host ID for %s.: " "$NETWORK_PREFIX"
  read HOST_ID
  [ -z "$HOST_ID" ] && exit 0
  IP="$NETWORK_PREFIX.$HOST_ID"
  ;;
"Insert IP address by yourself")
  printf "Enter IP address: "
  read IP
  [ -z "$IP" ] && exit 0
  ;;
*)
  IP="$SELECTION"
  ;;
esac

# Ask for port
printf "Enter port (default 9090): "
read PORT
PORT=${PORT:-9090}

# Launch nemo
nemo --geometry=1160x630 "ftp://$IP:$PORT"
