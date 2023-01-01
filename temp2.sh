str="sir you have $(echo $(task) | grep -o -E '[0-9] tasks' | cut -b 1-2) tasks pending..."

for(( i=0;i<${#str};i++))
do
	echo -n "${str:$i:1}" 
	sleep 0.03
done
