notify-send "..  Recording Started  .."
ffmpeg -y -f alsa -i default -acodec pcm_s16le -ac 1 -ar 44100 -t 5 -f wav /tmp/temp_audio.wav
notify-send ".  recording completed, wait a few sec  ."
whisper --language en --model small.en /tmp/temp_audio.wav --fp16 False --threads 8 --output_dir /tmp
notify-send "$(cat /tmp/temp_audio.txt)" -t 5000
cat /tmp/temp_audio.txt | wl-copy
# notify-send ".  Transcription Copied  ."
