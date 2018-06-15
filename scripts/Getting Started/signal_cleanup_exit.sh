#/bin/bash
# signal_cleanup_exit.sh

# This script will do cleanup when you try to exit via Ctrl+C

function cleanup_exit(){
	# do some file closing stuff
	# or temp file deletion stuff
	echo
}

trap cleanup_exit EXIT

echo "while true has started"
while true
do
	sleep 60
done
