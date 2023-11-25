#part1
clear
echo "Welcome to Gaz's arch installer script"
sleep 1
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 10/" /etc/pacman.conf
reflector --country "Austrelia,Germany,India,Taiwan,Singapore,Thailand,China" --save /etc/pacman.d/mirrorlist
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
lsblk
echo "Enter the drive: "
read drive
cfdisk $drive
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition
read -p "have you created new efi partition? [y/n]" answer
if [[ $answer = y ]]; then
	echo "Enter EFI partition: "
	read efipartition
	mkfs.vfat -F 32 $efipartition
fi
mount $partition /mnt
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >>/mnt/etc/fstab
sed '1,/^#part2$/d' $(basename $0) >/mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit

#part2
clear
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf
echo "KEYMAP=us" >/etc/vconsole.conf
echo "Hostname: "
read hostname
echo $hostname >/etc/hostname
echo "127.0.0.1  localhost" >>/etc/hosts
echo "::1        localhost ip6-localhost ip6-loopback" >>/etc/hosts
echo "ff02::1    ip6-allnodes" >>/etc/hosts
echo "ff02::2    ip6-allrouters" >>/etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >>/etc/hosts
mkinitcpio -P
passwd

sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 10/" /etc/pacman.conf
reflector --country "Austrelia,Germany,India,Taiwan,Singapore,Thailand,China" --save /etc/pacman.d/mirrorlist
pacman --noconfirm -Sy grub efibootmgr os-prober
lsblk
echo "Enter EFI partition: "
read efipartition
mkdir /boot/efi
mount $efipartition /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub
sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -Sy --noconfirm networkmanager wpa_supplicant rsync zip unzip unrar fzf git vim ttf-jetbrains-mono

systemctl enable NetworkManager.service

echo "Enter Username: "
read username
useradd -m -G wheel -s /bin/sh $username
passwd $username
echo "%wheel ALL=(ALL:ALL) ALL" >>/etc/sudoers

sed -i 's/#HandlePowerKey=poweroff/HandlePowerKey=ignore/' /etc/systemd/logind.conf
sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
sed -i 's/#HandleLidSwitchExternalPower=suspend/HandleLidSwitchExternalPower=ignore/' /etc/systemd/logind.conf

echo "Pre-Installation Finish Reboot now"

git clone https://github.com/cybergaz/scripts /home/$username/scripts
