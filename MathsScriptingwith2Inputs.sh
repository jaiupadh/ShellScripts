#! /bin/bash

#This is a script to perform various mathematical operations on the 2 inputs taken at begining.

echo "Enter a value for S1"
read S1

echo "Enter a value for S2"
read S2

echo "Addition Results : $S1 + $S2 ="
echo $(( S1 + S2 ))

#Alternatively this can be achieved with the following command
#echo $(expr $S1 + $S2)

echo "Subtraction Results : $S1 - $S2 ="
echo $(( S1 - S2 ))

#Alternatively this can be achieved with the following command
#echo $(expr $S1 - $S2)

echo "Multiplication Results $S1 * $S2 ="
echo $(( S1 * S2 ))

#Alternatively this can be achieved with the following command
#echo $(expr $S1 \* $S2)

if [ $S2 != 0 ]
then	
	echo "Division Results $S1 / $S2 ="
	echo $(( S1 / S2 ))

#Alternatively this can be achieved with the following command
#echo $(expr $S1 / $S2)

else 
	echo "Division Results of $S1 / $S2 is Infinity"
fi

if [ $S2 != 0 ]
then 
	echo "Remainder Results for $S1 / $S2 ="
	echo $(( S1 % S2 ))

#Alternatively this can be achieved with the following command
#echo $(expr $S1 % $S2)

else
	echo "Remainder Results for $S1 / $S2 is Invalid"
fi

exit
