#part1
clear
echo "Welcome to Gaz's arch installer script"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 10/" /etc/pacman.conf
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
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 10/" /etc/pacman.conf
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
pacman --noconfirm -S grub efibootmgr os-prober
lsblk
echo "Enter EFI partition: "
read efipartition
mkdir /boot/efi
mount $efipartition /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub
sed -i 's/#GRUB_DISABLE_OS_PROBER=true/GRUB_DISABLE_OS_PROBER=false/g' /etc/default/grub
os-prober
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm networkmanager wpa_supplicant rsync zip unzip unrar fzf

systemctl enable NetworkManager.service

echo "%wheel ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
echo "Enter Username: "
read username
useradd -m -G wheel -s /bin/zsh $username
passwd $username
echo "Pre-Installation Finish Reboot now"

git clone https://github.com/cybergaz/scripts /home/$username/scripts
