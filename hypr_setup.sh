#!/bin/bash
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo cp ~/scripts/mirrorlist /etc/pacman.d/mirrorlist
sudo cp ~/scripts/pacman.conf /etc/pacman.conf

sudo pacman -Sy --needed git base-devel && git clone https://aur.archlinux.org/yay.git ~/yay_build && cd ~/yay_build && makepkg -si
rm -rf ~/yay_build

# sudo reflector --country "Austrelia,Germany,India,Taiwan,Singapore,Thailand,China" --save /etc/pacman.d/mirrorlist

yay -Sy rate-mirrors-bin gvim wget
rate-mirrors --allow-root arch | sudo tee /etc/pacman.d/mirrorlist
yay -Syu

yay -S make wlroots wayland-protocols pkgconf ninja patch catch2 spdlog-git waybar brightnessctl pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber sof-firmware pavucontrol polkit-gnome grim slurp fish-git fisher-git firefox-nightly-bin hyprland-git wofi alacritty foot-git nemo mako neofetch btop viewnior swayidle swaylock-effects waylogout-git swww zoxide cliphist wtype wl-clipboard kora-icon-theme ttf-twemoji-color noto-fonts noto-fonts-emoji ttf-joypixels ttf-jetbrains-mono bluez bluez-utils mpv ffmpeg gparted greetd greetd-tuigreet acpi usbutils xdg-utils ntfs-3g exfat-utils dosfstools mtpfs jmtpfs gvfs-mtp gvfs-gphoto2
# noto-fonts-cjk ttf-jetbrains-mono ttf-font-awesome

git clone https://github.com/cybergaz/Hyprland_Rice ~/hyprland_temp

mkdir -p ~/.local/bin
cp -r ~/hyprland_temp/.config ~
sudo rm -rf ~/scripts
cd ~ && git clone https://github.com/cybergaz/scripts
cp ~/scripts/wofi-emoji/wofi-emoji ~/.local/bin/

mkdir -p ~/Pictures/Screenshots

sudo cp ~/hyprland_temp/pacman.conf /etc

git clone https://github.com/yeyushengfan258/Lyra-Cursors && cd Lyra-Cursors && ./install.sh
sudo cp -r ~/hyprland_temp/gtk/Layan-Dark /usr/share/themes/
# sudo cp -r ~/hyprland_temp/gtk/cursor/LyraB /usr/share/icons/
gsettings set org.gnome.desktop.interface gtk-theme Layan-Dark
gsettings set org.gnome.desktop.interface icon-theme kora
gsettings set org.gnome.desktop.interface cursor-theme LyraB

systemctl --user enable pipewire.socket
systemctl --user enable pipewire.service
systemctl --user start pipewire.socket
systemctl --user start pipewire.service

sudo systemctl enable bluetooth.service

# echo "(greetd) what's your default username?? :"
# read name
sed -i "s/^user = '.*'\$/user = '$(whoami)'/" ~/hyprland_temp/greetd/config.toml
sudo cp -r ~/hyprland_temp/greetd /etc/
sudo systemctl enable greetd.service

sudo chsh -s /usr/bin/fish $(whoami)
sudo chsh -s /usr/bin/fish root
echo "setting up fish shell is not tested yet, although according to my predictions it might work"
fish -c "fisher install IlanCosman/tide"

# echo "if the script is stucked here , then you need different network ( it's just zsh shell remaining in here nothing much)"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# cp ~/hyprland_temp/.zshrc ~
# cp ~/hyprland_temp/.p10k.zsh ~

echo "...hyprland setup completed..."
echo "cleaning up unnecessary files..."
rm -rf ~/hyprland_temp
