temp=$1
list=( $(sudo updatedb && cd / && sudo locate $temp) )


for i in "${list[@]}"
do
	sudo rm -r $i
done
