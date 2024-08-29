while true; do
	WALLPAPER="$(fd -a . $HOME/.config/hypr/wallpapers | sort -R | head -1)"
	swww img --transition-type any "$WALLPAPER"
	sleep 600
done
