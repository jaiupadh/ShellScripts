######################################################################
#     BASH Script to get Public&Private IPV4 address 	             #
#                 Authored by JAIUPADH on 23/05/2025                 #
#                         Version 1                                  #
######################################################################
#!/bin/bash
PuIP=$(curl ifconfig.me)
PrIP=$(hostname -I | awk '{print $1}')
echo -e "\n Public IPV4 Address: $PuIP"
echo -e " \n Private IPV4 Address: $PrIP"
echo -e "\n Exiting...."
