#! /bin/bash

# 'echo' command is used to display text.

args=("$@")

# '$@' indicates unlimited number of arguments that can be specified in the array

#to print just 3 elements of the array use the command commented out below

#echo ${args[0]} ${args[1]} ${args[2]}

#to print out all the values of the array use command commented out below

echo $@

#to print the length of the array use the command commected out below

echo $#
