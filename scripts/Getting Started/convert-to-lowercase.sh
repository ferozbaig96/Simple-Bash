#/bin/bash
# convert-to-lowercase.sh

# to convert a string to lowercase

echo "HELLO how are YOU" | tr '[A-Z]' '[a-z]'


# to convert a file contents to lowername

read -p "Enter a filename : "

if [ ! -f "$REPLY" ]
then
	echo "Filename '$REPLY' does not exist"
	exit 1
else
	tr '[A-Z]' '[a-z]' < $REPLY
fi


