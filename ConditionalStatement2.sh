#! /bin/bash

#this is an example for conditional statement script.

count=10

#Note that '[]' has to be replaced by using '(())' when using operators like '>' or '<' instead of -eq.

if [ $count -ne 9 ]
then
	echo "condition is true"

else
	echo "condition is false"
fi


#ne - not equal to 
#gt -greater than

