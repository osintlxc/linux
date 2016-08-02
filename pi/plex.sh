#!/bin/bash 

sudo apt-get install libc6 -y &&
sudo apt-get install apt-transport-https -y --force-yes &&
wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key | sudo apt-key add - &&
echo "deb https://dev2day.de/pms/ jessie main" | sudo tee /etc/apt/sources.list.d/pms.list &&
sudo apt-get update &&
sudo apt-get install plexmediaserver -y
