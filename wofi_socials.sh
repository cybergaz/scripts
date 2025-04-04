string=$(sed '1,/^### DATA ###$/d' $0 | cut -d= -f1 | wofi --show dmenu --sort-order alphabetical --normal-window --conf ~/.config/wofi/config_logout -s ~/.config/wofi/style_hz.css) &&
    sed '1,/^### DATA ###$/d' $0 | grep "$string=" | sed 's/.*'"$string"'="\([^"]*\)".*/\1/' | wl-copy
exit
### DATA ###
Portfolio="https://cybergaz.me"
LinkedIn="https://www.linkedin.com/in/cybergaz"
Github="https://github.com/cybergaz"
Email="gaz.sync@gmail.com"
Phone="8534946840"
