while ! ping -c 1 archlinux.org; do
	true
done
hyprctl dispatch exec spotify
hyprctl dispatch exec vesktop
sleep 10
hyprctl dispatch closewindow Spotify
hyprctl dispatch closewindow vesktop
