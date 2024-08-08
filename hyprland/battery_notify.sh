if [ -s "$XDG_RUNTIME_DIR/battery_script.pid" ]; then
    exit
fi

echo $$ >$XDG_RUNTIME_DIR/battery_script.pid

SLEEP_TIME=30
full_flag=0
low_flag=0
crit_flag=0
vcrit_flag=0
while [ true ]; do
    capc=$(cat /sys/class/power_supply/BAT*/capacity)
    if [[ $(cat /sys/class/power_supply/BAT*/status) != "Discharging" ]]; then # -- charging state
        shutdown -c --no-wall                                                  # -- cancel pending shutdowns if any
        low_flag=0
        crit_flag=0
        vcrit_flag=0
        if (($capc == 100)); then
            if ((full_flag != 1)); then
                notify-send "       energy replenished completely"
                full_flag=1
            fi
        fi
        SLEEP_TIME=30

    else # -- discharging state

        full_flag=0
        if (($capc >= 60)); then
            SLEEP_TIME=40
        else
            SLEEP_TIME=30
            if (($capc <= 10)); then
                SLEEP_TIME=20
                if ((low_flag != 1)); then
                    notify-send "    battery low" "\nfind the charger" -u low -t 6000
                    low_flag=1
                fi

            fi
            if (($capc <= 5)); then
                SLEEP_TIME=15
                if ((crit_flag != 1)); then
                    notify-send "    critical level" "plug-in charger asap" -u critical -t 6000
                    crit_flag=1
                fi
            fi
            if (($capc <= 3)); then
                SLEEP_TIME=10
                if ((vcrit_flag != 1)); then
                    notify-send "    out of juice" "shutdown in 1 minute" -u critical -t 8000
                    shutdown --no-wall

                    vcrit_flag=1
                fi

            fi
        fi

    fi
    #echo "$capc sl_time = $SLEEP_TIME"
    sleep $SLEEP_TIME
done
