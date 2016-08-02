#!/bin/bash 

sudo git clone git://github.com/RuudBurger/CouchPotatoServer.git /usr/local/couchpotato && 
sudo wget -O /etc/init.d/couchpotato https://raw.githubusercontent.com/robertbeal/linux/master/pi/couchpotato/couchpotato &&
sudo chmod 644 /etc/init.d/couchpotato &&
sudo update-rc.d couchpotato defaults &&
sudo service couchpotato start
