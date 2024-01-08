#!/bin/bash

echo "NOTE :"
echo "this script currently only works in PWD where all the episodes and subtitles are in present in order"
echo ""

# VIDEO_DIR="./"
#
# # Change to the video directory
# cd "$VIDEO_DIR" || exit

# Loop through each video file
video_array=()
for video_file in *.mkv; do
	# echo "$video_file"
	video_array+=("$video_file")
	# Extract the episode number from the video filename
	# episode_number=$(echo "$video_file" | grep -oE '^[0-9]+')
	#
	# # Find the corresponding subtitle file
	# subtitle_file=$(find . -maxdepth 1 -type f -name "${episode_number}*.srt" -print -quit)
	#
	# # If a matching subtitle file is found, play the video with subtitles
	# if [ -n "$subtitle_file" ]; then
	# 	mpv --sub-file="$subtitle_file" "$video_file"
	# else
	# 	echo "Subtitle not found for $video_file"
	# fi
done

# echo "${video_array[@]}"

subs_array=()
for subs in *.srt; do
	# echo "$subs"
	subs_array+=("$subs")
done

# echo "${subs_array[@]}"

for ((i = 0; i < ${#subs_array[@]}; i++)); do
	video_array[$i]=${video_array[$i]::-3}
	new_subs="${video_array[$i]}srt"

	echo ""
	echo "old subtitle :"
	echo "${subs_array[$i]}"

	mv "${subs_array[$i]}" "$new_subs"

	echo ""
	echo "new substitle :"
	echo "$new_subs"
	# mv "$subs_array[$i]" "$new_subs"
	# echo "${subs_array[i]}"
done
