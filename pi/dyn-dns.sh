#!/bin/bash

if ifconfig tun0 | grep -q "inet addr:" ; then
  echo "Unable to update Dynamic IP...VPN up"
else
  echo "Updating Dynamic IP..."
  
  # No-IP uses emails as passwords, so make sure that you encode the @ as %40
  IP=$(wget -O - http://icanhazip.com/ -o /dev/null)  
  curl -u $USERNAME:$PASSWORD "http://dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$IP"
fi
