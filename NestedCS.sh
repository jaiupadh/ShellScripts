#! /bin/bash

#this is an example for conditional statement script.

count=10

#Note that '[]' has to be replaced by using '(())' when using operators like '>' or '<' instead of -eq.

if (( $count < 9 ))
then
	echo "the condition 1 is true"
elif(( $count > 9 ))
then
	echo "the condition 2 is true"
else
	echo "both the conditions are false"
fi

#ne - not equal to
#gt -greater than
