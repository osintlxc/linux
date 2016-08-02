#!/bin/bash 

curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb http://apt.syncthing.net/ syncthing release" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt-get update
sudo apt-get install syncthing
sudo wget -O /etc/init.d/syncthing https://raw.githubusercontent.com/robertbeal/linux/master/pi/syncthing/syncthing
sudo chmod +x /etc/init.d/syncthing
sudo update-rc.d syncthing defaults
sudo /etc/init.d/syncthing restart
