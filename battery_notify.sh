SLEEP_TIME=30
full_flag=0
low_flag=0
crit_flag=0
vcrit_flag=0
while [ true ]; do
	capc=$(cat /sys/class/power_supply/BAT1/capacity)
	if [[ $(cat /sys/class/power_supply/BAT1/status) != "Discharging" ]]   		  	   				        # -- charging state
	then
		shutdown -c   									# -- closing the pending shutdowns from critical shutdown action
		low_flag=0
		crit_flag=0
		vcrit_flag=0
		if (( $capc >=84 )); then
			if (( full_flag != 1 )) ; then
				notify-send "  Battery FULL" "max limit reached \nYou can plug-out now.." 
				full_flag=1
			fi
		fi
		SLEEP_TIME=100

	else 											# -- discharging state

		full_flag=0
		if (( $capc >= 60 )); then
		       SLEEP_TIME=80
	        else
		       SLEEP_TIME=60
		       if (( $capc <= 10 )); then
			       SLEEP_TIME=30
			       if (( low_flag != 1 )); then
			       		notify-send "  Battery LOW" "\nPlug-in the charger asap.." -u critical -t 6000
					low_flag=1
			       fi

		       fi
		       if (( $capc <= 5 )); then
			       SLEEP_TIME=20
			       if (( crit_flag != 1 )); then
			       		notify-send "  CRITICAL level reached" "Plug-in the fuckin charger\ni'm gonna die...." -u critical -t 8000
					crit_flag=1
			       fi
		       fi
		       if (( $capc <= 3 )); then
			       SLEEP_TIME=20
			       if (( vcrit_flag != 1 )); then
			       		notify-send "  Out Of Juice" "\nSHUTDOWN in 1 minute.." -u critical -t 10000
			       		shutdown
				        vcrit_flag=1
			       fi

		       fi
		fi

	fi
	#echo "$capc sl_time = $SLEEP_TIME"
	sleep $SLEEP_TIME
done

