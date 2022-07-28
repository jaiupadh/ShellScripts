#! /bin/bash

#This is a script to compare the Strings taken as input match each other.

echo "Enter a value for S1"
read S1

echo "Enter a value for S2"
read S2

if [ "$S1" == "$S2" ]
then
	echo "The Values Entered Match"
else 
	echo "The Values Entered Don't Match"
fi
