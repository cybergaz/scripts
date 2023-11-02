#!/bin/bash
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo cp ~/scripts/mirrorlist /etc/pacman.d/mirrorlist
sudo cp ~/scripts/pacman.conf /etc/pacman.conf

sudo pacman -Sy --needed git base-devel && git clone https://aur.archlinux.org/yay.git ~/yay_build && cd ~/yay_build && makepkg -si
rm -rf ~/yay_build

git clone https://github.com/cybergaz/Hyprland_Rice ~/hyprland_temp

# sudo cp ~/hyprland_temp/pacman.conf /etc/pacman.conf
# sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
# sudo cp ~/hyprland_temp/mirrorlist /etc/pacman.d/mirrorlist

# sudo reflector --country "Austrelia,Germany,India,Taiwan,Singapore,Thailand,China" --save /etc/pacman.d/mirrorlist

yay -Sy rate-mirrors-bin gvim wget
rate-mirrors --allow-root arch | sudo tee /etc/pacman.d/mirrorlist
yay -Syu

yay -S make wlroots wayland-protocols pkgconf ninja patch catch2 spdlog-git waybar-hyprland-git brightnessctl pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber sof-firmware pavucontrol polkit-gnome grim slurp firefox hyprland-git wofi alacritty foot-git nemo mako neofetch btop viewnior swayidle swaylock-effects waylogout-git swww zoxide cliphist wtype wl-clipboard kora-icon-theme ttf-twemoji-color noto-fonts noto-fonts-emoji ttf-joypixels ttf-victor-mono-nerd bluez bluez-utils mpv ffmpeg gparted greetd greetd-tuigreet acpi usbutils xdg-utils ntfs-3g exfat-utils dosfstools mtpfs jmtpfs gvfs-mtp gvfs-gphoto2
# noto-fonts-cjk ttf-jetbrains-mono ttf-font-awesome

mkdir -p ~/.local/bin
cp -r ~/hyprland_temp/.config ~
cd ~ && git clone https://github.com/cybergaz/scripts
cp ~/scripts/wofi-emoji/wofi-emoji ~/.local/bin/

sudo cp -r ~/hyprland_temp/gtk/Cyberpunk /usr/share/themes/
sudo cp -r ~/hyprland_temp/gtk/cursor/LyraB /usr/share/icons/

mkdir -p ~/Pictures/Screenshots

sudo cp ~/hyprland_temp/pacman.conf /etc

echo "what is your default username :"
read name
sed -i "s/^user = ''$/user = '$name'/" ~/hyprland_temp/greetd/config.toml
sudo cp -r ~/hyprland_temp/greetd /etc/
sudo systemctl enable greetd.service

gsettings set org.gnome.desktop.interface gtk-theme Cyberpunk
gsettings set org.gnome.desktop.interface icon-theme kora
gsettings set org.gnome.desktop.interface cursor-theme LyraB

systemctl --user enable pipewire.socket
systemctl --user enable pipewire.service
systemctl --user start pipewire.socket
systemctl --user start pipewire.service

sudo systemctl enable bluetooth.service

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cp ~/hyprland_temp/.zshrc ~
cp ~/hyprland_temp/.p10k.zsh ~

mkdir -p ~/.local/share/fonts
wget -P ~/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
chmod 444 ~/.local/share/fonts/*
chmod 555 ~/.local/share/fonts/*
