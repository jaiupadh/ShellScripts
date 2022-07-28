#! /bin/bash
#####################################################################################################################
#                               Shell Script Created on 15-Aug-21                                                   #
#    This is a script to cleanup Cisco AnyConnect VPN Client on MacOS X & Created by Jaidev Upadhya(jaiupadh)       #
#####################################################################################################################

echo "AnyConnect Clean Up in Progress...... Time for Coffee Break ;)"

cd /opt/cisco/anyconnect/bin

sudo sh websecurity_uninstall.sh
sudo pkgutil -- forget com.cisco.pkg.anyconnect.websecurity_v2

echo "AnyConnect Web Security Module has been uninstalled successfully"

sudo sh amp_uninstall.sh
sudo pkgutil -- forget com.cisco.pkg.anyconnect.fireamp

echo "AnyConnect AMP Enabler Module has been uninstalled successfully"

sudo sh dart_uninstall.sh
sudo pkgutil -- forget com.cisco.pkg.anyconnect.dart

echo "AnyConnect DART Module has been uninstalled successfully"

sudo sh isecompliance_uninstall.sh
sudo pkgutil -- forget com.cisco.pkg.anyconnect.posture

echo "AnyConnect Posture Module has been uninstalled successfully"

sudo sh iseposture_uninstall.sh
sudo pkgutil -- forget com.cisco.pkg.anyconnect.iseposture

echo "AnyConnect ISE Posture Module has been uninstalled successfully"


sudo sh nvm_uninstall.sh
sudo pkgutil -- forget com.cisco.pkg.anyconnect.nvm_v2

echo "AnyConnect Network Visibility Module has been uninstalled successfully"

sudo sh umbrella_uninstall.sh
sudo pkgutil -- forget com.cisco.pkg.anyconnect.umbrella

echo "AnyConnect Umbrella (OpenDNS) Module has been uninstalled successfully"

sudo sh vpn_uninstall.sh
sudo pkgutil -- forget com.cisco.pkg.anyconnect.vpn

echo "AnyConnect Secure Mobility Client has been successfully uninstalled cleaning up other modules"


echo "Removing remaining left over files"
sudo rm -rf /opt/cisco/anyconnect
sudo rm -rf /opt/cisco/vpn
sudo rm -rf ~/.cisco/
sudo rm -rf ~/.anyconnect/
sudo sh anyconnect_uninstall.sh

echo "Cisco AnyConnect VPN Client has been wiped from this MacOS Successfully -> Submitting the logs & Exiting"

sudo jamf recon

echo "You can install Cisco AnyConnect VPN Client from SelfService.app > Sign in with CEC whenever prompted > Under Software Section look for Cisco AnyConnect VPN Client"

exit()
