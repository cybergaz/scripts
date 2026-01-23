notify-send "..  Recording Started  .."
mpv --no-terminal ~/Downloads/start-13691.mp3 &
ffmpeg -y -f alsa -i default -acodec pcm_s16le -ac 1 -ar 44100 -t 5 -f wav /tmp/temp_audio.wav
notify-send ".  recording completed, wait a few sec  ."
mpv --no-terminal ~/Downloads/data-reveal-sound-6460.mp3 &
whisper --language en --model base.en /tmp/temp_audio.wav --fp16 False --threads 8 --output_dir /tmp
notify-send "$(cat /tmp/temp_audio.txt)" -t 5000
mpv --no-terminal ~/Downloads/interface-124464.mp3 &
cat /tmp/temp_audio.txt | wl-copy
# notify-send ".  Transcription Copied  ."
