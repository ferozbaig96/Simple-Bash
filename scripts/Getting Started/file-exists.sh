#/bin/bash
# file-exists.sh

# Script to check if a filename exists

read -p "Enter a filename : "

# -f checks if it is a regular file
# double quotes for multi word filename
if [ ! -f "$REPLY" ]
then
	echo "Filename '$REPLY' does not exist"
	exit 1
else
	echo "Processing '$REPLY'"
fi
