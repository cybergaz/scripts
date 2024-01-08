#!/bin/bash

#echo "
#  _,  _,  _, __,   _, _  _, __, _, _ _ _, _  _,
# / _ / \ / \ | \   |\/| / \ |_) |\ | | |\ | / _
# \ / \ / \ / |_/   |  | \ / | \ | \| | | \| \ /
#  ~   ~   ~  ~     ~  ~  ~  ~ ~ ~  ~ ~ ~  ~  ~
#
#"

h=$(date +"%H")
if [ $h -gt 6 -a $h -le 12 ]; then
	gt="good morning"
elif [ $h -gt 12 -a $h -le 16 ]; then
	gt="good afternoon"
elif [ $h -gt 16 -a $h -le 20 ]; then
	gt="good evening"
else
	gt="good night"
fi

user="$(whoami)"
li=("...:: welcome back sir ::..." "..:: hi $user , welcome again ::.." "..:: $gt $user , what do you have for me  ::.." "...:: here you go ::..." "Hello $user..::..How are you?" "..:: on your demand boss ::.." "..:: ready to recieve commands sir ::.." "...:: hello $user , $gt ::..." "..:: $gt sir ::.." "..:: ready for action as always ::.." "..:: Hungry for commands boss ::.." "..:: $gt $user , what's next?" "..:: nice to see you again $user ::..." "..:: $gt $user , how are you ::.." "..:: welcome back sir ::.." "..:: what do you want ::.." "..:: just type it ::.." "..:: give me a command already ::.." "..:: hello mr $user , $gt to you ::.." "..:: what do you want this time huh ::.." "..:: at your service sir ::.." "..:: $gt sir , where have you been this whole time sir ::.." "..:: put it on fire ::..")

echo "${li[$((RANDOM % ${#li[@]}))]}"
