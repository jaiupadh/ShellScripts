#! /bin/bash
###############################################################################################################
#                    Shell Script Created on 15-Aug-21                                                        #
#  This is a shell script to clear WebEx Desktop Client Cache on MacOS & Created by Jaidev Upadhya(jaiupadh)  #
###############################################################################################################

rm -rf ~/Library/Caches/Cisco-Systems.Spark
rm -rf ~/Library/Caches/Cisco Spark
rm -rf ~/Library/Caches/Sparkle
rm -rf ~/Library/Caches/Spark 3705
rm -rf ~/Library/Application Support/Cisco-System.Spark
rm -rf ~/Library/Application Support/Cisco Spark
rm -rf ~/Library/Preferences/Cisco-Systems.Spark.plist
rm -rf ~/Library/Caches/com.plausiblelabs.crashreporter.data

sudo pkgutil --forget mc.mac.webex.com

echo "WebEx Cache has been wiped out from MacOS... Please move WebEx to trash & attempt to re-install WebEx from WebEx.com/Downloads.html"

echo "##############"
echo "++++++++++++++"
echo "Exiting Script"
echo "++++++++++++++"
echo "##############"

exit
