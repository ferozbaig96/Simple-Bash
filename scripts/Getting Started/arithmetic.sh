#/bin/bash
# arithmetic.sh : Script to do various arithmetic expressions

a=5
b=2
echo "a=$a, b=$b"

x=02
echo "Equality Check"
# -eq is used for arithmetic equality check
# == is used for string equality check
echo -n "$x -eq 2 : "
[ $x -eq 2 ] && (echo "yes") || (echo "no") # prints yes
echo -n "$x == 2 : "
[ $x == 2 ] && (echo "yes") || (echo "no") # prints no

# Add
x=`expr $a + $b`
echo "Add : $x"

# Subtract
x=`expr $a - $b`
echo "Subtract : $x"

# Multiplication
# NOTE : Escape the * operator
x=`expr $a \* $b`
echo "Multiplication : $x"

# Division
x=`expr $a / $b`
echo "Division : $x"

# To find length of string
str="Hello World!"
echo "Length of $str : ${#str}"
# Won't work with space character
x=`expr length $str`
echo "Length of $str : $x"
# Works without space character
str="Hello"
x=`expr length $str`
echo "Length of $str : $x"

#To find the index/position of character in a string
str="hello"
x=`expr index $str l`
echo "Index of l in $str : $x"




