pulseaudio-ctl down 2
notify-send.sh --replace=$(makoctl list | jq -r '.data[0][0].id.data') "Volume" -t 1000 -h int:value:$(pulseaudio-ctl full-status | awk '{print $1;}')
