#!/bin/bash

#To check if sudo access is present
if [ "$(id -u)" -eq 0 ]; then
	echo "You have logged in as root & sudo access is present"
	#To check and list firewall rules using iptables
	echo "Firewall rules:"
	iptables -L -n -v
elif groups | grep -q '\bsudo\b'; then
	echo "sudo access is present"
	#To check and list firewall rules using iptables
	echo "Firewall rules:"
	sudo iptables -L -n -v
else
	echo "sudo access is absent"
fi
