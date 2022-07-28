#! /bin/bash

for  (( i=0; i<=10; i++ )) #Most popular Syntax usage of For loop.
do
	if [ $i -gt 5 ]
	then
		break
	fi
	echo $i
done

#This Syntax of For Loop is used across various programming languages.
#Conditional Loop statement example for break usage.
