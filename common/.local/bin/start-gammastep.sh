while ! ping -c 1 -W 1 8.8.8.8; do
	true
done
while true; do
	pgrep gammastep || gammastep-indicator -t 6500:1500 -l $(curl -s ipinfo.io/loc | sed 's/,/:/g')
done
