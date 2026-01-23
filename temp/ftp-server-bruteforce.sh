# this script is used to find ftp servers in the local network and open them in nemo file manager

IPs=$(ip neighbour | grep "REACHABLE" | awk '$1 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {print $1}')
readarray -t ip_array <<<"$IPs"

# define ports to check and argument port if any
defined_ports=(9090 21 2221 3000 $1)

# while true; do
for ip in "${ip_array[@]}"; do
    found=0
    for port in "${defined_ports[@]}"; do
        echo "Checking $ip:$port"
        if curl -I "ftp://$ip:$port" >/dev/null 2>&1; then
            echo "FTP server found at $ip:$port"
            echo "opening nemo for ftp $ip:$port"
            nemo --geometry=1160x630 "ftp://$ip:$port"
            echo "exiting"
            exit
        fi
    done
    if [ $found -eq 0 ]; then
        echo "No FTP server found at $ip's known ports"
        echo "starting port bruteforce for $ip"
        for port in {1..65535}; do
            echo "Checking $port"
            # skip port 53
            if [ $port -eq 53 ]; then
                continue
            fi
            if curl -I "ftp://$ip:$port" >/dev/null 2>&1; then
                echo "FTP server found at $ip:$port"
                echo "opening nemo for ftp $ip:$port"
                nemo --geometry=1160x630 "ftp://$ip:$port"
                echo "exiting"
                exit
            fi
        done
    fi
done
#     sleep 1
# done
