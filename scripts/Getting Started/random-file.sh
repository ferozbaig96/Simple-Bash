#/bin/bash
# random-file.sh

# Script to create a file based on time and save it to /tmp dir

DIR="/tmp"
FILENAME=`date +%d-%m-%y-%H-%M-%S`
EXTENSION=".txt"

echo "Starting"
uptime >> "$DIR/$FILENAME$EXTENSION"
echo "File saved to $DIR/$FILENAME$EXTENSION"

