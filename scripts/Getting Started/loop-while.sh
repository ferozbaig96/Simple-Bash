#/bin/bash
# loop-while.sh

# https://unix.stackexchange.com/questions/18886/why-is-while-ifs-read-used-so-often-instead-of-ifs-while-read

text=' hello  world\
foo\bar'

printf '%s\n' "$text" | while IFS= read -r line;
do
	printf '%s\n' "[$line]"
done

echo -e "\n\nAnother Example\n\n"


# Another example

while read
do
	echo $REPLY
done < /etc/passwd

# ----------
# https://bash.cyberciti.biz/guide/While_loop

# IFS is used to set field separator (default is while space).
# The -r option to read command disables backslash escaping (e.g., \n, \t).
# This is failsafe while read loop for reading text files.


while IFS= read -r line
do
	command1 on $line
done < input_file


# ----------
# https://stackoverflow.com/questions/13122441/how-do-i-read-a-variable-on-a-while-loop
# To take input from a multi-line variable

while IFS= read -r line
do
    echo "$line"
done <<< "$the_list"

# IFS= sets $IFS to the empty string (so it doesn't contain any characters at all). 
# In this case, since there's only one field, its only effect is to prevent the removal of leading IFS-characters from the start of the line. 
# # To see what I mean, compare 
# 	read foo <<< ' bar' ; echo "$foo" 
# with
# 	IFS= read foo <<< ' bar' ; echo "$foo"
