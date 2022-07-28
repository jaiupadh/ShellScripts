#! /bin/bash

for  (( i=0; i<=10; i++ )) #Most popular Syntax usage of For loop.
do
	if [ $i -eq 3 ] || [ $i -eq 7 ]
	then
		continue
	fi
	echo $i
done

#This Syntax of For Loop is used across various programming languages.
#Conditional Loop statement example for continue usage.
