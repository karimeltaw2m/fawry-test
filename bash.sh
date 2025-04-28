#!/bin/bash


dig internal.example.com
dig @8.8.8.8 internal.example.com

curl -I http://internal.example.com
ss -tlnp | grep ':80\|:443'

sudo nano /etc/resolv.conf 

sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

sudo systemctl restart nginx
sudo systemctl restart apache2

curl -I http://internal.example.com
