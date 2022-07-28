#! /bin/bash

#This is a script to compare the length of Strings taken as input.

echo "Enter a value for S1"
read S1

echo "Enter a value for S2"
read S2

if [ "$S1" \< "$S2" ]
then
	echo "$S1 is smaller than $S2"
elif [ "$S1" \> "$S2" ]
then
	echo  "$S2 is smaller than $S1"
else
	echo "The Strings are Equal"
fi
