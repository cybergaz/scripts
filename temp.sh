id=$(notify-send -p "shutdown countdown" "60")
for ((i = 60; i > 0; i--)); do
	notify-send -r $id "shutdown countdown" "$i"
	sleep 1
done
