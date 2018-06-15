#/bin/bash
# confirm.sh

# This script will confirm [yes or no] for a task

echo "Starting.."

# prompting user with msg, and reading only 1 character
CONFIRM_MSG="Are you sure? [y/n] : "
read -n 1 -p "$CONFIRM_MSG" VAL_REPLY
echo

#if [[ $VAL_REPLY =~ [yY] ]]
#then
#	echo "Exiting.."
#	exit 0;
#elif [[ $VAL_REPLY =~ [nN] ]]
#then
#	echo "Nope..."
#else	echo "Wrong input"
#fi

case $VAL_REPLY in
	[yY] )	echo "Exiting.."; exit 0;;
	[nN] )	echo "Nope...";;
	* )	echo "Wrong input";;
esac


