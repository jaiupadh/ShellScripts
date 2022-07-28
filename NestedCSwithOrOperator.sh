#! /bin/bash

#this is an example for nested conditional statement script.

count=1

#Note that '[]' has to be replaced by using '(())' when using operators like '>' or '<' instead of -eq.

#Alternatively this can be achieved like - if [ "$count" -gt 18 ] || [ "$count" -lt 60 ]

#Alternatively this also can be achieved like - if [[ "$count" -gt 18 || "$count" -lt 60 ]]

if [ "$count" -gt 18 -o "$count" -eq 60 ]

then
	echo "Count is greater than 18 or is equal to 60"

elif [ "$count" -gt 60 -o "$count" -eq 100 ]
then
	echo "Count is greater than 60 or is equal to 100"
else
	echo "undefined condition"
fi

#ne - not equal to
#gt -greater than
#lt -less than
