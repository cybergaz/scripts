temp=$1
list=($(sudo updatedb && cd / && sudo locate $temp))

for i in "${list[@]}"; do
	echo "removed: $i"
	sudo rm -rf $i
done
