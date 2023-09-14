#!/bin/sh
#ejjewe

wl-paste | qrencode -t PNG -s 8 -o /tmp/temp_qr.png
viewnior /tmp/temp_qr.png
