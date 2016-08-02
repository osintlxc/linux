#!/bin/bash 

sudo wget -O /etc/init.d/hosts https:///hosts.sh &&
sudo chmod 644 /etc/init.d/hosts-updater &&

# dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E &&
sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ wily main" >> /etc/apt/sources.list.d/dropbox.list' &&
sudo apt-get update &&
sudo apt-get install -y dropbox &&

# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &&
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' &&
sudo apt-get update &&
sudo apt-get install -y google-chrome-stable &&
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 10' &&

# android tools
sudo add-apt-repository ppa:nilarimogard/webupd8 &&
sudo add-apt-repository ppa:upubuntu-com/sdk &&
sudo apt-get update &&
sudo apt-get install -y android-tools-adb android-tools-fastboot &&

# atom
sudo add-apt-repository ppa:webupd8team/atom &&
sudo apt-get update &&
sudo apt-get install -y atom &&

# codecs
sudo apt-get install -y ubuntu-restricted-extras flashplugin-installer &&

# internet
sudo apt-get install -y network-manager-vpnc network-manager-vpnc-gnome rdesktop &&

# system
sudo apt-get install -y gparted rar p7zip-full gnome-system-tools libappindicator1 eyed3 unity-tweak-tool &&
 
# media
sudo apt-get install -y vlc mp3gain sound-juicer && 

# dev
sudo apt-get install -y tmux curl vim git git-gui &&

# remove
sudo apt-get remove -y rhythmbox evolution empathy unity-webapps-* apport xterm shotwell thunderbird firefox &&
sudo apt-get install -y unity-webapps-common &&
sudo apt-get autoremove -y &&

# flickr
sudo apt-get install python-pip &&
easy_install -U pip &&
sudo pip install requests[security]
sudo pip install flickrbackup &&

# vcs details
EMAIL="foo@bar.com" &&
NAME="Foo Bar" &&
git config --global user.email "$EMAIL" &&
git config --global user.name "$NAME" &&
git config --global alias.c commit &&
git config --global alias.s status &&
git config --global alias.a add &&
git config --global alias.d diff &&
git config --global push.default simple &&
