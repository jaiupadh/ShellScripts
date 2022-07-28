#! /bin/bash

#this is an example for nested conditional statement script.

age=10

#Note that '[]' has to be replaced by using '(())' when using operators like '>' or '<' instead of -eq.

if [ "$age" -gt 18 ] && [ "$age" -lt 60 ]

#Alternatively this can be achieved like - if [[ "$age" -gt 18 && "$age" -lt 60 ]]

#Alternatively this can be also achieved like - if [ "$age" -gt 18 -a "$age" -lt 60 ]]

then
	echo "Age is between 18 to 60 - Adult"

elif [ "$age" -gt 60 ] && [ "$age" -lt 100 ]
then
	echo "Age is between 60 to 100 - Senior Citizen"
else
	echo "Age is lesser than 18 - Young Blood"
fi

#ne - not equal to
#gt -greater than
#lt -less than
