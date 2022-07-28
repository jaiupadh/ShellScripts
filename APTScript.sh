#! /bin/bash


#This ia an example script to update & upgrade linux packages installed || LINUX House Keeping for all debian based linux distros - Created by Jaidev Upadhya

echo "###########################"
echo "Updating Packages Installed"
echo "###########################"

sleep 10s

sudo apt update && sudo apt upgrade -y

sleep 10s

echo "#######################################"
echo "Fixing Broken Installation Dependancies"
echo "#######################################"

sleep 10s

sudo apt --fix-broken install -y

sleep 10s

echo "#####################"
echo "Updating Linux Distro"
echo "#####################"

sleep 10s

sudo apt dist-upgrade -y

sleep 10s

echo "##############################"
echo "Removing the Outdated Packages"
echo "##############################"

sleep 10s

sudo apt autoremove -y

sleep 10s

echo "####################################"
echo "++++++++++++++++++++++++++++++++++++"
echo "************************************"
echo "Successfully Completed House Keeping"
echo "************************************"
echo "++++++++++++++++++++++++++++++++++++"
echo "####################################"
