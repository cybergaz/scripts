#capturing partial screenshots with editing options

tempfile="/tmp/$(date +'%s.png')"
grim -g "$(slurp)" $tempfile &&
	satty -f $tempfile --init-tool brush --output-filename $tempfile --early-exit &&
	notify-send ".  Partial Screenshot Captured  ."
mv $tempfile $HOME/Pictures/Screenshots/
