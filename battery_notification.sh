export DISPLAY=:0

battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
if [ $battery_level -lt 84 ]; then
	notify-send "Battery Full" "Max Limit Reached : ${battery_level}%\nYou Can Plug-Out Now.." -u low
elif [ $battery_level -lt 15 ]; then
	notify-send "Bettery Low" "You Should PLug-In Charger ASAP.." -u critical
elif [ $battery_level -le 7 ]; then
	notify-send "Bettery is CRITICALLY LOW" "Plug-In ASAP..\nI'm Gonna Die..." -u critical
	paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
fi
