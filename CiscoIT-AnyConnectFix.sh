#! /bin/bash
##########################################################################################################################################
#                                     Shell Script Created on 27-Aug-21                                                                  #
# This is a shell script to remove corrupted binaries in Cisco AnyConnect VPN Client on MacOS X & Created by Jaidev Upadhya(jaiupadh)    #
##########################################################################################################################################

echo "Fixing IP Forwarding Table Issue ..."

cd /opt/cisco/anyconnect/bin

A[]=($(ls | grep routechangesv))

echo ${A[*]}
if((${#A[@]}));
then
	echo "Binaries that we are looking for is not found; Please try rebooting MAC or Re-installing Cisco AnyConnect VPN Client "
else
	echo "#####################################################"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "+ Binaries found -> Removing the Corrupted Binaries +"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "#####################################################"
	rm routechangesv4.bin
	rm routechangesv6.bin
	echo "Process Completed -> Please try establishing a VPN connection again; A system reboot might be required"
	echo "Exiting ..."
fi
