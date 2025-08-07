while ! ping -c 1 -W 1 8.8.8.8; do
	true
done

COORDINATES=$(curl -s ipinfo.io/loc | sed 's/,/:/g')
while true; do
	gammastep -t 6500:1500 -l "$COORDINATES"
done
