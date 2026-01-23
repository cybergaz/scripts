notify-send "..  Recording Started  .."
mpv --no-terminal ~/Downloads/start-13691.mp3 &
ffmpeg -y -f alsa -i default -acodec pcm_s16le -ac 1 -ar 44100 -t 3 -f wav /tmp/temp_audio.wav
notify-send ".  recording completed, wait a few sec  ."
mpv --no-terminal ~/Downloads/data-reveal-sound-6460.mp3 &
whisper --language en --model base.en /tmp/temp_audio.wav --fp16 False --threads 8 --output_dir /tmp
notify-send "$(cat /tmp/temp_audio.txt)" -t 4000
mpv --no-terminal ~/Downloads/interface-124464.mp3 &
text=$(cat /tmp/temp_audio.txt)
text_lower=$(echo "$text" | tr '[:upper:]' '[:lower:]')
echo $text_lower

if [[ "$text_lower" == *"firefox"* && "$text_lower" == *"google"* ]]; then
	firefox -new-window google.com
elif [[ "$text_lower" == *"browser"* || "$text_lower" == *"firefox"* ]]; then
	firefox
elif [[ "$text_lower" == *"play"*"music"* ]]; then
	firefox -new-window music.youtube.com
else
	notify-send "hehe" "what!!!"
fi
# notify-send ".  Transcription Copied  ."
