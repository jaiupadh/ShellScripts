#! /bin/bash

#This is a script to convert HexaDecimal value of the input to Decimal Value & display output

echo "Enter HexaDecimal Number of your choice"
read Hex

echo -n "The Decimal Value of $Hex is : "

echo "obase=10; ibase=16; $Hex" | bc

exit
