oklch-color-picker $(grim -g "$(slurp -p)" -t ppm - | magick - -format '%[pixel:p{0,0}]' txt:- | awk -F ' ' 'NR==2 {print $3}') | tr -d '[:space:]' | wl-copy
