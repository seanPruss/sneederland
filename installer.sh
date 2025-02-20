#!/usr/bin/env bash
# ▄▄▄▄▄▄                                           ▄▄▄▄      ▄▄▄▄                                      ▄▄▄▄                           ██
# ▀▀██▀▀                         ██                ▀▀██      ▀▀██                                    ▄█▀▀▀▀█                          ▀▀                 ██
#   ██     ██▄████▄  ▄▄█████▄  ███████    ▄█████▄    ██        ██       ▄████▄    ██▄████            ██▄        ▄█████▄   ██▄████   ████     ██▄███▄   ███████
#   ██     ██▀   ██  ██▄▄▄▄ ▀    ██       ▀ ▄▄▄██    ██        ██      ██▄▄▄▄██   ██▀                 ▀████▄   ██▀    ▀   ██▀         ██     ██▀  ▀██    ██
#   ██     ██    ██   ▀▀▀▀██▄    ██      ▄██▀▀▀██    ██        ██      ██▀▀▀▀▀▀   ██                      ▀██  ██         ██          ██     ██    ██    ██
# ▄▄██▄▄   ██    ██  █▄▄▄▄▄██    ██▄▄▄   ██▄▄▄███    ██▄▄▄     ██▄▄▄   ▀██▄▄▄▄█   ██                 █▄▄▄▄▄█▀  ▀██▄▄▄▄█   ██       ▄▄▄██▄▄▄  ███▄▄██▀    ██▄▄▄
# ▀▀▀▀▀▀   ▀▀    ▀▀   ▀▀▀▀▀▀      ▀▀▀▀    ▀▀▀▀ ▀▀     ▀▀▀▀      ▀▀▀▀     ▀▀▀▀▀    ▀▀                  ▀▀▀▀▀      ▀▀▀▀▀    ▀▀       ▀▀▀▀▀▀▀▀  ██ ▀▀▀       ▀▀▀▀
#                                                                                                                                            ██

# HyprV4 By SolDoesTech - https://www.youtube.com/@SolDoesTech
# License..? - You may copy, edit and ditribute this script any way you like, enjoy! :)

# The follwoing will attempt to install all needed packages to run Hyprland
# This is a quick and dirty script there are some error checking
# IMPORTANT - This script is meant to run on a clean fresh Arch install on physical hardware

# Env var for where the repo was cloned
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Define the software that would be inbstalled
#Need some prep work
prep_stage=(
	xdg-user-dirs
	wget
	stow
	plocate
	qt5-wayland
	qt5ct
	qt6-wayland
	qt6ct
	qt5-svg
	qt5-quickcontrols2
	qt5-graphicaleffects
	gtk3
	hyprpolkitagent
	hyprland-qtutils
	pipewire
	wireplumber
	jq
	wl-clipboard
	cliphist
	python-requests
	pacman-contrib
	mkinitcpio-archlogo
	cpio
)

#software for nvidia GPU only
nvidia_stage=(
	linux-headers
	nvidia-dkms
	nvidia-settings
	libva
	libva-nvidia-driver-git
)

#the main packages
install_stage=(
	flatpak
	ufw
	hyprpaper
	pyprland
	playerctl
	man-db
	man-pages
	kanata-bin
	fd
	bat
	git-delta
	rust
	rust-analyzer
	jdk-openjdk
	npm
	vlc
	composer
	auto-cpufreq
	banana-cursor-bin
	ghostty
	dunst
	vesktop
	battery-notify
	waybar
	power-profiles-daemon
	wttrbar
	imagemagick
	gimp
	hyprlock
	tofi
	rofimoji
	xdg-desktop-portal-hyprland
	xdg-desktop-portal-gtk
	swappy
	grim
	slurp
	htim
	zen-browser-bin
	gammastep
	shellcheck
	fzf
	tealdeer
	nushell
	vivid
	carapace
	trash-cli
	starship
	yazi
	ueberzugpp
	ffmpegthumbnailer
	unarchiver
	poppler
	fastfetch
	shell-color-scripts-git
	tmux
	sesh-bin
	ripgrep
	neovim
	lazygit
	zoxide
	eza
	toilet
	toilet-fonts
	fortune-mod
	cowsay
	rose-pine-gtk-theme
	dracula-gtk-theme
	gruvbox-gtk-theme-git
	beautyline
	libreoffice-fresh
	thunderbird
	mpv
	pamixer
	pavucontrol-compact-git
	brightnessctl
	bluez
	bluez-utils
	blueman
	network-manager-applet
	gvfs
	file-roller
	ttf-jetbrains-mono-nerd
	noto-fonts-emoji
	xfce4-settings
	nwg-look
	sddm
	archlinux-themes-sddm
	catppuccin-sddm-theme-mocha
	chili-sddm-theme
	sddm-archlinux-theme-git
	sddm-theme-abstractdark-git
	sddm-theme-corners-git
	sddm-theme-mnmlst
	sddm-theme-tokyo-night-git
	simple-sddm-theme-2-git
	simple-sddm-theme-git
	win11-sddm-theme
)

flatpaks=(
	com.spotify.Client
)

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
INSTLOG=$REPO_DIR/install.log

######
# functions go here

# function that would show a progress bar to the user
show_progress() {
	while ps | grep $1 &>/dev/null; do
		echo -n "."
		sleep 2
	done
	echo -en " Done!\n"
	sleep 1
}

# clear the screen
clear

# set some expectations for the user
echo -e "$CNT - You are about to execute a script that would attempt to setup Hyprland.
Please note that Hyprland is still in Beta."

# attempt to discover if this is a VM or not
echo -e "$CNT - Checking for Physical or VM..."
ISVM=$(hostnamectl | grep Chassis)
echo -e "Using $ISVM"
if [[ $ISVM == *"vm"* ]]; then
	echo -e "$CWR - Please note that VMs are not fully supported and if you try to run this on
    a Virtual Machine there is a high chance this will fail."
fi

# let the user know that we will use sudo
echo -e "$CNT - This script will run some commands that require sudo. You will be prompted to enter your password.
If you are worried about entering your password then you may want to review the content of the script.
IMPORTANT: yay will panic if a package it is trying to install conflicts with an already installed package.
Feel free to look through the package list and remove any packages that would conflict (AUR packages that may be development branches of official packages).
ALSO: There are a lot of packages that will be installed. While each package in the list is installed sequentially setting up parallel downloads in pacman.conf
will allow dependencies to be downloaded concurrently saving time."

# give the user an option to exit out
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to continue with the install (y,n) ' CONTINST
if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
	echo -e "$CNT - Setup starting..."
	sudo touch /tmp/hyprv.tmp
else
	echo -e "$CNT - This script will now exit, no changes were made to your system."
	exit
fi

# find the Nvidia GPU
if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
	ISNVIDIA=true
else
	ISNVIDIA=false
fi

### Disable wifi powersave mode ###
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to disable WiFi powersave? (y,n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
	LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
	echo -e "$CNT - The following file has been created $LOC.\n"
	echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC &>>$INSTLOG
	echo -en "$CNT - Restarting NetworkManager service, Please wait."
	sudo systemctl restart NetworkManager &>>$INSTLOG

	#wait for services to restore (looking at you DNS)
	for i in {1..6}; do
		echo -n "."
		sleep 1
	done
	echo -en "Done!\n"
	echo -e "\e[1A\e[K$COK - NetworkManager restart completed."
fi

sudo pacman -S reflector --needed --noconfirm &>>$INSTLOG || exit
echo -e "$CNT - Updating mirrorlist"
sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist &>>$INSTLOG || exit
echo -e "\e[1A\e[K$COK - Mirrorlist updated."

#### Check for package manager ####
if ! which yay &>/dev/null; then
	echo -en "$CNT - Installing yay."
	git clone https://aur.archlinux.org/yay-bin.git &>>$INSTLOG
	cd yay-bin || exit
	makepkg -si --noconfirm &>>$INSTLOG &
	show_progress $!
	sleep 2
	if [ -e "$(which yay)" ]; then
		echo -e "\e[1A\e[K$COK - yay installed"
		cd ..

		# update the yay database
		echo -en "$CNT - Running a system update."
		yay -Syyu --noconfirm &>>$INSTLOG &
		show_progress $!
		echo -e "\e[1A\e[K$COK - System updated."
	else
		# if this is hit then a package is missing, exit to review log
		echo -e "\e[1A\e[K$CER - yay install failed, please check the install.log"
		exit
	fi
else
	echo -en "$CNT - Running a system update."
	yay -Syyu --noconfirm &>>$INSTLOG &
	show_progress $!
	echo -e "\e[1A\e[K$COK - System updated."
fi

sudo cp $REPO_DIR/cleancache.hook /usr/share/libalpm/hooks
sudo cp $REPO_DIR/clearcache /usr/share/libalpm/scripts

# Prep Stage - Bunch of needed items
echo -e "$CNT - Prep Stage - Installing needed components, this may take a while..."
for SOFTWR in ${prep_stage[@]}; do
	yay -S --noconfirm --needed $SOFTWR || exit
done

# Setup Nvidia if it was found
if [[ "$ISNVIDIA" == true ]]; then
	echo -e "$CNT - Nvidia GPU support setup stage, this may take a while..."
	for SOFTWR in ${nvidia_stage[@]}; do
		yay -S --noconfirm --needed $SOFTWR || exit
	done

	# update config
	sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
	sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
	echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf &>>$INSTLOG
fi

# Install the correct hyprland version
echo -e "$CNT - Installing Hyprland, this may take a while..."
yay -S --needed --noconfirm hyprland || exit

# Stage 1 - main components
echo -e "$CNT - Installing main components, this may take a while..."
for SOFTWR in ${install_stage[@]}; do
	yay -S --needed --noconfirm $SOFTWR || exit
done

# Flatpaks
echo -e "$CNT - Installing flatpaks..."
for SOFTWR in ${flatpaks[@]}; do
	flatpak install $SOFTWR || exit
done

# generate symlinks for dotfiles
cd $REPO_DIR || exit
xdg-user-dirs-update &>>$INSTLOG
# Initialize with Rose Pine config
stow --target=$HOME dotfiles-rose-pine &>>$INSTLOG
stow --override=.* --target=$HOME common &>>$INSTLOG

# Start the bluetooth service
echo -e "$CNT - Starting the Bluetooth Service..."
sudo systemctl enable --now bluetooth.service &>>$INSTLOG

# Enable the sddm login manager service
echo -e "$CNT - Enabling the SDDM Service..."
sudo systemctl enable sddm &>>$INSTLOG

# Enable auto-cpufreq service
echo -e "$CNT - Enabling the auto-cpufreq Service..."
sudo systemctl enable auto-cpufreq &>>$INSTLOG

# Enable power-profiles-daemon service
echo -e "$CNT - Enabling the power-profiles-daemon Service..."
sudo systemctl enable power-profiles-daemon &>>$INSTLOG

# Enable screen lock service
echo -e "$CNT - Enabling the screen lock Service..."
sudo cp $REPO_DIR/suspend@.service /etc/systemd/system
sudo systemctl enable suspend@$USER.service &>>$INSTLOG

# Clean out other portals
echo -e "$CNT - Cleaning out conflicting xdg portals..."
yay -Q xdg-desktop-portal-gnome &>/dev/null && yay -R --noconfirm xdg-desktop-portal-gnome &>>$INSTLOG

# Set up sddm
echo -e "$CNT - Setting up the login screen."
[[ -d /etc/sddm.conf.d ]] || sudo mkdir /etc/sddm.conf.d
sudo cp $REPO_DIR/random-sddm-theme.service /etc/systemd/system
sudo cp $REPO_DIR/random-sddm-theme.sh /usr/bin
sudo systemctl enable random-sddm-theme.service &>>$INSTLOG
WLDIR=/usr/share/wayland-sessions
if [ -d "$WLDIR" ]; then
	echo -e "$COK - $WLDIR found"
else
	echo -e "$CWR - $WLDIR NOT found, creating..."
	sudo mkdir $WLDIR
fi

# Set up plocate
echo -e "$CNT - Updating plocate database"
sudo updatedb &>>$INSTLOG

# Install catppuccin gtk theme
echo -e "$CNT - Installing catppuccin gtk theme"
curl -LsSO "https://raw.githubusercontent.com/catppuccin/gtk/v1.0.3/install.py" &>>$INSTLOG
python3 install.py mocha red &>>$INSTLOG

# Set up ufw
echo -e "$CNT - Setting up UFW"
sudo ufw limit 22/tcp &>>$INSTLOG
sudo ufw allow 80/tcp &>>$INSTLOG
sudo ufw allow 443/tcp &>>$INSTLOG
sudo ufw default deny incoming &>>$INSTLOG
sudo ufw default allow outgoing &>>$INSTLOG
sudo ufw enable &>>$INSTLOG

# Set up tpm for tmux
echo -e "$CNT - Setting up tmux plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &>>$INSTLOG

# Set up tldr
echo -e "$CNT - Setting up tldr"
tldr --update &>>$INSTLOG

### Install software for Asus ROG laptops ###
read -rep $'[\e[1;33mACTION\e[0m] - For ASUS ROG Laptops - Would you like to install Asus ROG software support? (y,n) ' ROG
if [[ $ROG == "Y" || $ROG == "y" ]]; then
	echo -e "$CNT - Adding Keys..."
	sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>>$INSTLOG
	sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>>$INSTLOG
	sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>>$INSTLOG
	sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>>$INSTLOG

	LOC="/etc/pacman.conf"
	echo -e "$CNT - Updating $LOC with g14 repo."
	echo -e "\n[g14]\nServer = https://arch.asus-linux.org" | sudo tee -a $LOC &>>$INSTLOG
	echo -e "$CNT - Update the system..."
	sudo pacman -Syu --noconfirm &>>$INSTLOG

	echo -e "$CNT - Installing ROG pacakges..."
	yay -S --needed --noconfirm asusctl || exit
	yay -S --needed --noconfirm supergfxctl || exit
	yay -S --needed --noconfirm rog-control-center || exit

	echo -e "$CNT - Activating ROG services..."
	sudo systemctl enable --now power-profiles-daemon.service &>>$INSTLOG
	sudo systemctl enable --now supergfxd &>>$INSTLOG

	# add the ROG keybinding file to the config
	echo -e "\nsource = ~/.config/hypr/rog-g15-strix-2021-binds.conf" >>~/.config/hypr/hyprland.conf
fi

### Script is done ###
echo -e "$CNT - Script had completed!"
if [[ "$ISNVIDIA" == true ]]; then
	echo -e "$CAT - Since we attempted to setup an Nvidia GPU the script will now end and you should reboot.
    Please type 'reboot' at the prompt and hit Enter when ready."
	exit 0
fi

echo -e "$CNT - If you are using a laptop, consider using the kanata service to remap your laptop keyboard for easier access to modifier keys. Just run these commands after ensuring that the device specified in config.kbd is the correct one:
sudo cp $REPO_DIR/kanata.service /etc/systemd/system
sudo cp $REPO_DIR/config.kbd /etc
sudo systemctl enable kanata.service
"

echo -e "$CNT - run git status and if there are changes, remove the changes with lazygit then reboot"
exit 0
