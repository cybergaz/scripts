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

li=("...:: welcome back sir ::..." "..:: hi Gaz , welcome again ::.." "..:: $gt Gaz , what do you have for me  ::.." "...:: here you go ::..." "Hello Gaz..::..How are you?" "..:: on your demand boss ::.." "..:: ready to recieve commands sir ::.." "...:: hello Gaz , $gt ::..." "..:: $gt sir ::.." "..:: ready for action as always ::.." "..:: Hungry for commands boss ::.." "..:: $gt Gaz , what's next?" "..:: nice to see you again Gaz ::..." "..:: $gt Gaz , how are you ::.." "..:: welcome back sir ::.." "..:: what do you want ::.." "..:: just type it ::.." "..:: give me a command already ::.." "..:: hello mr Gaz , $gt to you ::.." "..:: what do you want this time huh ::.." "..:: at your service sir ::.." "..:: $gt sir , where have you been this whole time sir ::.." "..:: put it on fire ::..")

echo "${li[$((RANDOM % ${#li[@]}))]}"
