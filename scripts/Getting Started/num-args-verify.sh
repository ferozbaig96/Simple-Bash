#/bin/bash
# num-args-verify.sh

# Script to verify the number of arguments

USAGE="Usage : $0 source destination"

if [ ! $# -eq 2 ]
then
	echo $USAGE;
	exit 1;
else
	echo "Some processing"
fi
