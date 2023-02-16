grep -E $(wofi --show dmenu -e -H 100) ~/nps.cache | cat > /tmp/temp_output && cat /tmp/temp_output | wofi --show dmenu -H 600 -W 900 | grep -E -o "nixpkgs*.*:" | sed 's/..$//' | wl-copy && rm ~/temp_output


#where nps.cache is the package list file created via " nix-env -qaP"

#dependecies : 
# wl-clipboard
# wofi dmenu
