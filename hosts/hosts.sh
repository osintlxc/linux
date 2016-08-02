#!/bin/bash 

if [ ! -f /etc/hosts.original ]; then
    cp /etc/hosts /etc/hosts.original
fi

wget https://hosts.local -O /etc/hosts.local
wget http://winhelp2002.mvps.org/hosts.txt -O /etc/hosts.blocklist
cat /etc/hosts.original /etc/hosts.local /etc/hosts.blocklist > /etc/hosts
