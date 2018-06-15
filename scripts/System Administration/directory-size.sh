#!/bin/bash
# directory-size.sh

echo "Enter your directory: "
read x

if [ "${x:0:1}" == "~" ]
then 
	x="$HOME/${x:2}"
fi

echo "Directory size for '$x' : "

du -sh "$x"
