#!/bin/bash 

# dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E &&
sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu trusty main" &&
# android
sudo add-apt-repository ppa:nilarimogard/webupd8 &&
sudo add-apt-repository ppa:upubuntu-com/sdk &&
# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &&
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' &&
# atom
sudo add-apt-repository ppa:webupd8team/atom &&

sudo apt-get update &&

# codecs
sudo apt-get install -y ubuntu-restricted-extras flashplugin-installer &&

# internet
sudo apt-get install -y dropbox google-chrome-stable network-manager-vpnc network-manager-vpnc-gnome rdesktop &&

# system
sudo apt-get install -y gparted rar p7zip-full gnome-system-tools libappindicator1 eyed3 &&
 
# media
sudo apt-get install -y vlc mp3gain && 

# dev
sudo apt-get install -y vim tmux curl git android-tools-adb android-tools-fastboot atom &&

# vpn
sudo apt-get install -y network-manager-openvpn &&
sudo wget -O /etc/openvpn/ca.vyprvpn.com.crt https://www.goldenfrog.com/downloads/ca.vyprvpn.com.crt &&

# remove
sudo apt-get remove -y rhythmbox evolution empathy firefox unity-webapps-* apport xterm &&
sudo apt-get autoremove -y &&

# flickr
sudo apt-get install python-pip &&
easy_install -U pip &&
sudo pip install requests[security]
sudo pip install flickrbackup &&

# privacy
gsettings set com.canonical.Unity.Lenses remote-content-search none &&
gsettings set com.canonical.Unity.Lenses disabled-scopes \
      "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope',
      'more_suggestions-populartracks.scope', 'music-musicstore.scope',
      'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope',
      'more_suggestions-skimlinks.scope']" &&
if ! grep -q productsearch.ubuntu.com /etc/hosts; then
	echo -e "\n127.0.0.1 productsearch.ubuntu.com" | sudo tee -a /etc/hosts >/dev/null
fi &&

# aliases
touch .bash_aliases &&
rm .bash_aliases &&
echo "alias install='sudo apt-get install'" >> .bash_aliases &&
echo "alias remove='sudo apt-get remove'" >> .bash_aliases &&
echo "alias update='sudo apt-get update'" >> .bash_aliases &&
echo "alias ..='cd ..'" >> .bash_aliases &&
echo "alias ...='cd ../../'" >> .bash_aliases &&
echo "alias shutdown='sudo shutdown –h now'" >> .bash_aliases && 
echo "alias restart='sudo shutdown –r now'" >> .bash_aliases &&
echo "alias g='git'" >> .bash_aliases &&
echo "alias gpush='git push'" >> .bash_aliases &&
echo "alias gs='git status'" >> .bash_aliases &&
echo "alias gpp='git pull --rebase && git push'" >> .bash_aliases &&
echo "alias gspps='git stash && git pull --rebase && git push && git stash pop'" >> .bash_aliases &&

# virtualbox
# sudo apt-get install -y virtualbox &&
# VBoxManage setextradata global GUI/Customizations noMenuBar,noStatusBar &&
# sudo usermod -aG vboxusers $USER &&

# vcs details
EMAIL="you@email.com" &&
NAME="Your Name" &&

# git
git config --global user.email "$EMAIL" &&
git config --global user.name "$NAME" &&
git config --global alias.c commit &&
git config --global alias.s status &&
git config --global alias.a add &&
git config --global alias.d diff &&
git config --global push.default simple &&

# swap
if [ -n "grep 'sysctl -w vm.swappiness' /etc/rc.local" ]; then
	sudo sed -i 's/exit 0/sysctl -w vm.swappiness=0\nexit 0/g' /etc/rc.local
fi &&

# hosts
if [ -n "grep '192.168.0.1 router' /etc/hosts" ]; then
	echo -e "192.168.0.1 router" | sudo tee -a /etc/hosts
fi

