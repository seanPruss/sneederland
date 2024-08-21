#!/bin/bash

# HyprV4 By SolDoesTech - https://www.youtube.com/@SolDoesTech
# License..? - You may copy, edit and ditribute this script any way you like, enjoy! :)

# The follwoing will attempt to install all needed packages to run Hyprland
# This is a quick and dirty script there are some error checking
# IMPORTANT - This script is meant to run on a clean fresh Arch install on physical hardware

# Env var for where the repo was cloned
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR=$REPO_DIR/config-files
# Define the software that would be inbstalled
#Need some prep work
prep_stage=(
	reflector
	qt5-wayland
	qt5ct
	qt6-wayland
	qt6ct
	qt5-svg
	qt5-quickcontrols2
	qt5-graphicaleffects
	gtk3
	polkit-gnome
	pipewire
	wireplumber
	jq
	wl-clipboard
	cliphist
	python-requests
	pacman-contrib
	mkinitcpio-firmware
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
	swww
	pyprland
	playerctl
	man-db
	man-pages
	fd
	bat
	git-delta
	rust
	jdk-openjdk
	cmatrix-git
	pipes-rs
	cava
	npm
	vlc
	composer
	auto-cpufreq
	rose-pine-hyprcursor
	kitty
	swaync
	waybar
	wttrbar
	imagemagick
	gimp
	hyprlock
	rofi-wayland
	wlogout
	xdg-desktop-portal-hyprland
	swappy-git
	grim-git
	slurp
	btop-gpu-git
	zen-browser-bin
	vesktop
	spotify
	spicetify-cli
	spicetify-themes-git
	spicetify-marketplace-bin
	geoclue
	gammastep
	shellcheck
	fzf
	tealdeer
	zsh
	zsh-auto-notify
	zsh-fast-syntax-highlighting-git
	zsh-autoswitch-virtualenv-git
	fzf-tab-git
	zsh-autosuggestions-git
	zsh-history-substring-search-git
	zsh-you-should-use
	zsh-autopair-git
	trash-cli
	oh-my-posh
	yazi
	ueberzugpp
	ffmpegthumbnailer
	unarchiver
	poppler
	bash-zsh-insulter
	fastfetch-git
	onefetch
	zellij
	ripgrep
	neovim
	lazygit
	zoxide
	eza
	rust-lolcat-git
	toilet
	toilet-fonts
	rose-pine-gtk-theme
	rose-pine-cursor
	beautyline
	libreoffice-fresh
	thunderbird
	mpv
	pamixer
	pulsecontrol-git
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
	sddm-git
	archlinux-themes-sddm
)

config_files=(
	.zshenv
	.gitconfig
)

config_dirs=(
	bat
	btop
	cava
	fastfetch
	fontconfig
	gtk-3.0
	gtk-4.0
	hypr
	kitty
	nvim
	nwg-look
	oh-my-posh
	rofi
	swaync
	systemd
	waybar
	wlogout
	xfce4
	xsettingsd
	yazi
	zellij
	zsh
)

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
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
	sleep 2
}

# function that will test for a package and if not found it will attempt to install it
install_software() {
	# Install a package if it is not installed or out of date with --needed flag
	echo -en "$CNT - Now installing $1."
	yay -S --needed --noconfirm $1 &>>$INSTLOG &
	show_progress $!
}

backup_and_link_file() {
	[[ -e ~/$1 ]] && mv ~/"$1" ~/"$1".bak
	ln -sf "$CONFIG_DIR/$1" ~/"$1" && echo -e "$COK linked $1" || echo -e "$CER failed to link $1"
}

backup_and_link_dir() {
	[[ -d ~/.config.bak ]] || mkdir ~/.config.bak
	[[ -e ~/.config/$1 ]] && mv ~/.config/"$1" ~/.config.bak/"$1"
	ln -sf "$CONFIG_DIR/$1" ~/.config/"$1" && echo -e "$COK linked $1 config" || echo -e "$CER failed to link $1 config"
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

sudo pacman -Syyu --noconfirm &>>$INSTLOG

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

sleep 5

#### Check for package manager ####
if [ -z "$(which yay)" ]; then
	echo -en "$CNT - Configuring yay."
	git clone https://aur.archlinux.org/yay.git &>>$INSTLOG
	cd yay || exit
	makepkg -si --noconfirm &>>$INSTLOG &
	show_progress $!
	sleep 2
	if [ -e "$(which yay)" ]; then
		echo -e "\e[1A\e[K$COK - yay configured"
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

sudo cp $CONFIG_DIR/cleancache.hook /usr/share/libalpm/hooks
sudo cp $CONFIG_DIR/clearcache /usr/share/libalpm/scripts
# Prep Stage - Bunch of needed items
echo -e "$CNT - Prep Stage - Installing needed components, this may take a while..."
for SOFTWR in ${prep_stage[@]}; do
	install_software $SOFTWR
done

# Setup Nvidia if it was found
if [[ "$ISNVIDIA" == true ]]; then
	echo -e "$CNT - Nvidia GPU support setup stage, this may take a while..."
	for SOFTWR in ${nvidia_stage[@]}; do
		install_software $SOFTWR
	done

	# update config
	sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
	sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
	echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf &>>$INSTLOG
fi

# Install the correct hyprland version
echo -e "$CNT - Installing Hyprland, this may take a while..."
install_software hyprland

# Stage 1 - main components
echo -e "$CNT - Installing main components, this may take a while..."
for SOFTWR in ${install_stage[@]}; do
	install_software $SOFTWR
done

# copy my configs
echo -e "$CNT Copying config files (dw I'm backing up your configs)"
for file in ${config_files[@]}; do
	backup_and_link_file $file
done

[[ -e ~/.config.bak ]] && rm -rf ~/.config.bak
for dir in ${config_dirs[@]}; do
	backup_and_link_dir $dir
done

# Start the bluetooth service
echo -e "$CNT - Starting the Bluetooth Service..."
sudo systemctl enable --now bluetooth.service &>>$INSTLOG

# Enable the sddm login manager service
echo -e "$CNT - Enabling the SDDM Service..."
sudo systemctl enable sddm &>>$INSTLOG

# Enable auto-cpufreq service
echo -e "$CNT - Enabling the auto-cpufreq Service..."
sudo systemctl enable auto-cpufreq &>>$INSTLOG

# Enable screen lock service
echo -e "$CNT - Enabling the screen lock Service..."
sudo cp $CONFIG_DIR/suspend@.service /etc/systemd/system
sudo systemctl enable suspend@$USER.service &>>$INSTLOG

# Clean out other portals
echo -e "$CNT - Cleaning out conflicting xdg portals..."
yay -Q xdg-desktop-portal-gnome &>/dev/null && yay -R --noconfirm xdg-desktop-portal-gnome &>>$INSTLOG
yay -Q xdg-desktop-portal-gtk &>/dev/null && yay -R xdg-desktop-portal-gtk &>>$INSTLOG

# Set up sddm
echo -e "$CNT - Setting up the login screen."
[[ -d /etc/sddm.conf.d ]] || sudo mkdir /etc/sddm.conf.d
[[ -f /etc/sddm.conf.d/10-theme.conf ]] || echo -e "[Theme]\nCurrent=archlinux-simplyblack" | sudo tee -a /etc/sddm.conf.d/10-theme.conf &>>$INSTLOG
WLDIR=/usr/share/wayland-sessions
if [ -d "$WLDIR" ]; then
	echo -e "$COK - $WLDIR found"
else
	echo -e "$CWR - $WLDIR NOT found, creating..."
	sudo mkdir $WLDIR
fi

# Build theme cache for bat
bat cache --build &>>$INSTLOG

# Need this for spicetify to work. I'm not sure if I wanna put the spicetify commands in the script
sudo chmod -R 777 /opt/spotify &>>$INSTLOG
sudo chmod -R 777 /usr/share/spicetify-cli &>>$INSTLOG

# Set up tldr
tldr --update

# set up zsh
chsh -s "$(which zsh)"

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
	sudo pacman -Suy --noconfirm &>>$INSTLOG

	echo -e "$CNT - Installing ROG pacakges..."
	install_software asusctl
	install_software supergfxctl
	install_software rog-control-center

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

read -rep $'[\e[1;33mACTION\e[0m] - Would you like to start Hyprland now? (y,n) ' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
	exec sudo systemctl start sddm &>>$INSTLOG
else
	exit 0
fi
