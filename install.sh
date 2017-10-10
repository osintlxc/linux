#!/bin/bash

# bunch of handy command for setting up an Arch install

# disable root
sudo passwd -l root &&

# personal group
sudo groupadd $USER &&
sudo gpasswd -a $USER $USER &&

# intel processor
sudo pacman -S --noconfirm intel-ucode &&

# gnome apps
sudo pacman -S --noconfirm gnome-packagekit gnome-calculator eog evince gthumb gnome-screenshot &&

# common system apps
sudo pacman -S --noconfirm cronie dnsmasq openssh p7zip gparted dosfstools fakeroot net-tools bind-tools mtpfs dconf-editor &&

# dev
sudo pacman -S --noconfirm gedit nano atom git gitg curl wget tmux meld jq &&

# web
sudo pacman -S --noconfirm firefox chromiumry qt4 vlc android-tools &&

### Hardening

sudo chmod 700 /boot &&
sudo chmod 700 /etc/iptables &&

## password policy
sudo sed -i "/.*pam_cracklib.so.*/c\password required pam_cracklib.so retry=2 minlen=10 difok=6 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1" /etc/pam.d/passwd &&

## kernel
cat sysctl.conf | sudo tee /etc/sysctl.d/51-net.conf &&
## ssh
cat sshd_config | sudo tee /etc/ssh/sshd_config &&
## sandbox
sudo pacman -S --noconfirm firejail lynis arch-audit &&
sudo firecfg &&
## rootkit
sudo pacman -S --noconfirm rkhunter;

# sysreq
echo "kernel.sysrq = 1" | sudo tee /etc/sysctl.d/99-sysctl.conf &&

# cinnamon
sudo pacman -S --noconfirm arc-icon-theme arc-gtk-theme nemo-fileroller lightdm-gtk-greeter-settings &&

# network manager
sudo pacman -S --noconfirm networkmanager networkmanager-openvpn network-manager-applet gnome-keyring libsecret ppp pptpclient &&
echo "[main]" | sudo tee --append /etc/NetworkManager/NetworkManager.conf &&
echo "dns=dnsmasq" | sudo tee --append /etc/NetworkManager/NetworkManager.conf &&

# fonts
## dejavu
sudo pacman -S --noconfirm freetype2 ttf-dejavu &&
sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d &&
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d &&
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d &&
sudo sed -i 's/^#export FREETYPE_PROPERTIES/export FREETYPE_PROPERTIES/' /etc/profile.d/freetype2.sh &&
cat fontconfig.xml | sudo tee /etc/fonts/local.conf &&
## msfonts
curl -L https://github.com/robertbeal/msfonts/raw/master/install.sh | sudo sh &&
## google fonts
curl https://raw.githubusercontent.com/qrpike/Web-Font-Load/master/install_arch.sh | sh &&
## settings
gsettings set org.gnome.desktop.interface document-font-name 'DejaVu Sans Condensed 11' &&
gsettings set org.gnome.desktop.interface font-name 'DejaVu Sans Condensed 9' &&
gsettings set org.gnome.desktop.interface monospace-font-name 'DejaVu Sans Mono Condensed 11' &&
gsettings set org.cinnamon.desktop.interface font-name 'DejaVu Sans Condensed 9.5' &&

# printing
sudo pacman -S --noconfirm cups cups-pdf system-config-printer gtk3-print-backends ghostscript gsfonts gutenprint &&
sudo pacman -S --noconfirm hplip &&
sudo systemctl enable org.cups.cupsd.service &&
sudo systemctl start org.cups.cupsd.service &&
sudo groupadd printadmin &&
sudo usermod -aG printadmin $USER &&
sudo sed -i "/SystemGroup sys root$/c\SystemGroup sys root printadmin" /etc/cups/cups-files.conf &&

# time
sudo pacman -S --noconfirm ntp &&
sudo systemctl enable ntpd &&
sudo systemctl start ntpd &&

# vim
sudo pacman -S --noconfirm vim &&
rm -Rf ~/.vim/bundle/ &&
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle.vim &&
git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim &&
git clone https://github.com/wookiehangover/jshint.vim.git ~/.vim/bundle/jshint.vim &&
git clone https://github.com/ervandew/supertab.git ~/.vim/bundle/supertab &&
git clone https://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic &&
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree &&

# synthing
sudo pacman -S --noconfirm syncthing &&
mkdir -p ~/.config/autostart &&
cat autostart/Syncthing.desktop | tee ~/.config/autostart/Syncthing.desktop &&
sudo ln -s /usr/bin/firejail /usr/local/bin/syncthing &&

# file permissions
## ssh
chmod 700 ~/.ssh &&
find ~/.ssh -type d -exec chmod 700 {} + &&
find ~/.ssh -type f -exec chmod 600 {} + &&
chmod -R 644 ~/.ssh/*.pub &&

### Other Sources

# homeshick
git clone git://github.com/andsens/homeshick.git ~/.homesick/repos/homeshick &&
if ! grep -q ".homesick/repos/homeshick/homeshick.sh" ~/.bashrc; then
    printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> ~/.bashrc &&
    source ~/.bashrc
fi
