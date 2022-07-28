#! /bin/bash

#this is an example for conditional statement case script.

Car="BMW"

#Pass the variable in the string

case "$Car" in
	#case 1
	"Mercedes") echo "Headquarters - Affalterbach, Germany" ;;
	#case 2
	"Audi") echo "Headquarters - Ingolstadt, Germany" ;;
	#case 3
	"BMW") echo "Headquarters - Chennai, Tamil Nadu, India" ;;
esac
