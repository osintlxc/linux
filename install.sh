#!/bin/bash 

# vcs details
EMAIL="your@gemail.com" &&
NAME="Your Name" &&

# medibuntu
sudo wget -q "http://packages.medibuntu.org/medibuntu-key.gpg" -O- | sudo apt-key add - &&

# apt-fast
sudo add-apt-repository ppa:apt-fast/stable &&

# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &&
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' &&

# dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E &&
sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu precise main" &&

sudo apt-get update &&
sudo apt-get install -y apt-fast &&

# tray icons
gsettings set com.canonical.Unity.Panel systray-whitelist "['Skype']" &&


# remove
sudo apt-fast remove -y rhythmbox tomboy gwibber thunderbird evolution nautilus-sendto ubuntuone-client empathy &&
sudo apt-fast autoremove -y &&

# codecs
sudo apt-fast install -y ubuntu-restricted-extras flashplugin-installer w64codecs non-free-codecs libdvdcss2 mencoder &&

# performance
sudo apt-fast install -y ureadahead prelink preload bum &&

# fs
sudo apt-fast install -y ssh sshfs samba gparted denyhosts &&

# system
sudo apt-fast install -y synaptic rar p7zip-full nautilus-dropbox network-manager-vpnc gnome-system-tools pyrenamer &&

# media
sudo apt-fast install -y mp3gain vorbisgain flickrbackup ufraw wine vlc gnome-raw-thumbnailer &&

# internet
sudo apt-fast install -y google-chrome-stable firefox &&

# dev
sudo apt-fast install -y git mercurial virtualbox &&

# aliases
touch .bash_aliases &&
rm .bash_aliases &&
touch .bash_aliases &&

echo "alias install='sudo apt-fast install'" >> .bash_aliases &&
echo "alias remove='sudo apt-fast remove'" >> .bash_aliases &&
echo "alias update='sudo apt-fast update'" >> .bash_aliases &&
echo "alias dev='cd Dev'" >> .bash_aliases &&
echo "alias ..='cd ..'" >> .bash_aliases &&
echo "alias ...='cd ../../'" >> .bash_aliases &&
echo "alias shutdown='sudo shutdown –h now'" >> .bash_aliases && 
echo "alias restart='sudo shutdown –r now'" >> .bash_aliases &&

# virtualbox
VBoxManage setextradata global GUI/Customizations noMenuBar,noStatusBar &&
sudo groupadd vboxusers &&
sudo usermod -aG vboxusers $USER &&

# git
git config --global user.email "$EMAIL" &&
git config --global user.name "$NAME" &&
git config --global alias.c commit &&
git config --global alias.s status &&
git config --global alias.a add &&
git config --global alias.d diff &&
git config --global alias. add &&
echo "alias g='git'" >> .bash_aliases &&
echo "alias gpush='git push'" >> .bash_aliases &&
echo "alias gs='git status'" >> .bash_aliases &&

# hg
touch .hgrc &&
rm .hgrc &&
touch .hgrc &&
echo "[ui]" >> .hgrc &&
echo "username = $NAME <$EMAIL>" >> .hgrc &&

# ruby
sudo apt-fast install ruby-rvm &&
sudo apt-fast --purge remove ruby-rvm &&
sudo rm -rf /usr/share/ruby-rvm /etc/rvmrc /etc/profile.d/rvm.sh &&
rm -R $HOME/.rvm &&
\curl -L https://get.rvm.io |   bash -s stable --ruby --autolibs=enable --auto-dotfiles &&
rvm reload &&
rvm install 2.0.0 &&

# hosts
echo -e "192.168.0.1 router" | sudo tee -a /etc/hosts &&
echo -e "192.168.0.4 xbmc"   | sudo tee -a /etc/hosts;
