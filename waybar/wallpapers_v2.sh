#!/bin/bash
#
# v2 is because this script changes wallpapers randomly but do not apply the same wallpaper twice
# until all the wallpapers has cycled ones then only it will consider used wallpapers again

# source directory for images
image_directory="$HOME/Downloads/img"

# check if the daemon is already running
if ! pgrep -x swww-daemon >/dev/null; then
	swww init
	echo "successfully enabled the swww daemon"
	echo $(ls $image_directory | wc -l) | cat >/tmp/swww_number_of_img
fi

# creating a temporary file with absolute wallpaper files path
function absolute_path() {
	output_file="/tmp/swww_unused_files"
	find "$image_directory" -type f -exec readlink -f {} \; >"$output_file"
	# echo "unused files output file updated"
}

# update with new file paths , whenever you make changes in the main directory of images (like bring new images or delete exisiting one)
no_of_img=$(ls $image_directory | wc -l)
if [ ! $(cat /tmp/swww_number_of_img) -eq $no_of_img ]; then
	# echo "updating index .........."
	echo $(ls $image_directory | wc -l) | cat >/tmp/swww_number_of_img
	absolute_path
fi

# update / generate new paths only if either file is missing or file is empty
unused_file_path="/tmp/swww_unused_files"
if [ ! -s "$unused_file_path" ] || [ ! -e "$unused_file_path" ]; then
	# echo "absolute path executed........"
	absolute_path

fi

# choose a random file from the temporary indexed files
random_line=$(shuf -n 1 "$unused_file_path")
# update the wallpaper with that newly chosen random file
swww img $random_line --transition-type grow --transition-step 0 --transition-pos top --transition-fps 255 --transition-bezier .2,1.7,0.4,1
# delete the line(file) from the temporary indexed file to make sure it will never get chosen at random (it will be available again once it done iterating over each file)
escaped_line=$(printf "%s\n" "$random_line" | sed 's/[\/&]/\\&/g')
sed -i "/$escaped_line/d" "$unused_file_path"
# echo "removed : $random_line"

echo "done"
