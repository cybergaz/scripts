#!/bin/bash

sudo pacman -S yay
yay -S rate-mirrors gvim neovim
rate-mirrors --allow-root arch | sudo tee /etc/pacman.d/mirrorlist

yay -S make wlroots wayland-protocols pkgconf ninja patch catch2 waybar-hyprland-git brightnessctl pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland-git polkit-gnome grim slurp sddm hyprland-git wofi kitty alacritty nemo ranger mako neofetch nitch btop viewnior swaybg swayidle swaylock-effects waylogout-git swww zoxide cliphist wtype wl-clipboard layan-gtk-theme-git kora-icon-theme layan-cursor-theme-git ttf-twemoji-color noto-fonts-emoji

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

mkdir /tmp/hyprland
git clone https://github.com/cybergaz/Hyprland_Rice /tmp/hyprland

cp -r /tmp/hyprland/.config ~
cp /tmp/hyprland/.zshrc ~
cp /tmp/hyprland/.p10k.zsh ~r
cd ~ && git clone https://github.com/cybergaz/scripts
cp ~/scripts/wofi-emoji/wofi-emoji ~/.local/bin/

mkdir ~/.local/share/fonts
wget -P ~/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
chmod 444 ~/.local/share/fonts/*
chmod 555 ~/.local/share/fonts/*

gsettings set org.gnome.desktop.interface gtk-theme Layan-Dark
gsettings set org.gnome.desktop.interface icon-theme kora
gsettings set org.gnome.desktop.interface cursor-theme Layan-cursors
