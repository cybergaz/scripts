#!/bin/bash

# Define a host to ping (e.g., Google's public DNS server)
ping_host="8.8.8.8"
# Check internet connectivity
if ping -q -c 1 -W 1 "$ping_host" >/dev/null; then
	echo "-------------------------------------------------------------------------------------------------------------------------------------------------------"
	echo -e "\t\t\t\t\t\tinternet connection is available , proceeding with the script"
	echo "-------------------------------------------------------------------------------------------------------------------------------------------------------"

	# script goes here
	# important for DNS resolution , cause some software/services only depended upon /etc/resolv.conf
	sudo ln -rsf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

	sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
	sudo cp ~/scripts/mirrorlist /etc/pacman.d/mirrorlist
	sudo cp ~/scripts/pacman.conf /etc/pacman.conf

	sudo pacman -Sy --needed git base-devel reflector && git clone https://aur.archlinux.org/yay-bin.git ~/yay_build && cd ~/yay_build && makepkg -si
	rm -rf ~/yay_build
	# sudo reflector --country "Austrelia,Germany,India,Taiwan,Singapore,Thailand,China" --save /etc/pacman.d/mirrorlist &&
	yay -Sy rate-mirrors && rate-mirrors --allow-root arch | sudo tee /etc/pacman.d/mirrorlist
	yay -Syu
	yay -S vim wget less ripgrep make wlroots wayland-protocols pkgconf ninja patch catch2 spdlog-git waybar brightnessctl pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber sof-firmware pavucontrol polkit-gnome grim slurp fish-git fisher-git firefox-nightly-bin hyprland-git wofi alacritty foot-git nemo mako neofetch btop viewnior swayidle swaylock-effects swww zoxide cliphist wtype wl-clipboard kora-icon-theme ttf-twemoji-color noto-fonts noto-fonts-emoji ttf-joypixels ttf-jetbrains-mono ttf-comfortaa ttf-poppins bluez bluez-utils mpv ffmpeg gparted greetd greetd-tuigreet acpi usbutils xdg-utils xdg-desktop-portal-hyprland-git ntfs-3g exfat-utils dosfstools mtpfs jmtpfs gvfs-mtp gvfs-gphoto2 neovim rsync iwgtk
	# noto-fonts-cjk ttf-jetbrains-mono ttf-font-awesome &&

	mkdir -p ~/.local/bin
	mkdir -p ~/.local/share/icons
	mkdir -p ~/Pictures/Screenshots

	git clone https://github.com/cybergaz/hyprland_rice ~/hyprland_temp
	cp -r ~/hyprland_temp/.config ~ &&
		sudo rm -rf ~/scripts &&
		cd ~ && git clone https://github.com/cybergaz/scripts &&
		sudo cp ~/hyprland_temp/pacman.conf /etc/ &&

		# gtk theming
		git clone https://github.com/yeyushengfan258/Lyra-Cursors && cd Lyra-Cursors && ./install.sh &&
		sudo cp -r ~/hyprland_temp/gtk/Layan-Dark /usr/share/themes/ &&
		# sudo cp -r ~/hyprland_temp/gtk/cursor/LyraB /usr/share/icons/ &&
		gsettings set org.gnome.desktop.interface gtk-theme Layan-Dark &&
		gsettings set org.gnome.desktop.interface icon-theme kora &&
		gsettings set org.gnome.desktop.interface cursor-theme LyraB &&

		# essensial services
		systemctl --user enable --now pipewire.socket &&
		systemctl --user enable --now pipewire.service &&
		sudo systemctl enable bluetooth.service &&

		# neovim setup
		rm -rf ~/.config/nvim &&
		git clone https://github.com/cybergaz/snow-vim ~/.config/nvim &&

		# display/login manager
		sed -i "s/^user = '.*'\$/user = '$(whoami)'/" ~/hyprland_temp/greetd/config.toml &&
		sudo cp -r ~/hyprland_temp/greetd /etc/ &&
		sudo systemctl enable greetd.service &&

		# fish shell
		sudo chsh -s /usr/bin/fish $(whoami) &&
		sudo chsh -s /usr/bin/fish root &&
		fish -c "fisher install IlanCosman/tide" &&

		# finishing up
		echo "...hyprland setup completed..." &&
		echo "cleaning up unnecessary files..." &&
		rm -rf ~/hyprland_temp &&
		echo -e "\n\n\n\n----------------------------------------------" &&
		echo -e "\tdone......  you can reboot now" &&
		echo "----------------------------------------------" &&
		exit

	echo -e "\n\n\n\nsomething went wrong with the installation "

else

	echo "-------------------------------------------------------------------------------------------------------------------------------------------------------"
	echo -e "\t\t\t\tInternet connection is not available , Aborting the script."
	echo "-------------------------------------------------------------------------------------------------------------------------------------------------------"
	echo -e "connection help : (if you use iwd -> \"iwctl station wlan0 connect [Network-Name]\" ; else use -> \"nmtui\")"

	exit 1
fi
