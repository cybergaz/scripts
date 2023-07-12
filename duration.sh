#!/bin/bash

start_time=0

while read -r line; do
	if [[ $line == *"key press"* ]]; then
		start_time=$(date +%s%N)
	elif [[ $line == *"key release"* ]]; then
		end_time=$(date +%s%N)
		duration=$(((end_time - start_time) / 1000000)) # Convert nanoseconds to milliseconds
		echo "Key press duration: ${duration} ms"
	fi
done
