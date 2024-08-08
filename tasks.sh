#!/bin/bash

lines=()

while IFS= read -r line; do
	lines+=("$line")
done <"$HOME/.tasks"
# arr=[$cat ~/.tasks]
# echo ${lines[@]}
for i in $(seq 1 $(wc -l ~/.tasks | awk '{ print $1 }')); do
	echo $i - ${lines[$i - 1]}
done
