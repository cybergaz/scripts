#!/bin/bash

#echo "
#  _,  _,  _, __,   _, _  _, __, _, _ _ _, _  _,
# / _ / \ / \ | \   |\/| / \ |_) |\ | | |\ | / _
# \ / \ / \ / |_/   |  | \ / | \ | \| | | \| \ /
#  ~   ~   ~  ~     ~  ~  ~  ~ ~ ~  ~ ~ ~  ~  ~ 
#                                               
#"

echo "______________________________"
echo "Hi... $USER"
h=$(date +"%H")
if [ $h -gt 6 -a $h -le 12 ]
then
echo ".....::Good Morning::...."
elif [ $h -gt 12 -a $h -le 16 ]
then
echo ".....::Good Afternoon::...."
elif [ $h -gt 16 -a $h -le 20 ]
then
echo ".....::Good Evening::...."
else
echo ".....::Good Night::...."
fi
echo "______________________________" 

