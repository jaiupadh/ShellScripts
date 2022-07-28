#! /bin/bash

#this is an example for conditional statement script.

count=10

#Note that '[]' can be replaced by using '(())'

if [ $count -eq 10 ]
then
	echo "condition is true"

else
	echo "condition is false"
fi
