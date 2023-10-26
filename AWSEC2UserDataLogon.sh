#!/bin/bash

#Use this for your user data (script from top to bottom) 

# install httpd (Linux version 2) 

yum update
yum install httpd -y 
systemctl start httpd 
systemctl enable httpd
echo "<h1> Hello World from $(hostname-f)</h1>" > /var/www/html/index.html