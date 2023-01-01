alacritty -t clock -e tty-clock -sb -C 4 &
sleep 0.7
$HOME/scripts/task.sh
sleep 3
pkill clock
exit
