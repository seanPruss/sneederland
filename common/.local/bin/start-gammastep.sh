while ! ping -c 1 archlinux.org; do
	true
done
gammastep-indicator -t 6500:1500 -l $(curl -s ipinfo.io/loc | sed 's/,/:/g')
