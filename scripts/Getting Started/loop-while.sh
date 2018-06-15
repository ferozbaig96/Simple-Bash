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
