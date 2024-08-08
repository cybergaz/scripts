notify-send "..  (base) Recording Started  .."
ffmpeg -y -f alsa -i default -acodec pcm_s16le -ac 1 -ar 16000 -t 4 -f wav /tmp/temp_audio.wav
notify-send ".  recording done , processing....  ."
~/gclones/whisper.cpp/main -m ~/gclones/whisper.cpp/models/ggml-base.en.bin -f /tmp/temp_audio.wav -t 10 -otxt
notify-send " $(cat /tmp/temp_audio.wav.txt) "
cat /tmp/temp_audio.wav.txt | wl-copy
