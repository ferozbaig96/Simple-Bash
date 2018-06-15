#/bin/bash
# leap-year.sh

USAGE="Usage: $0 year (in YYYY format)"

# spaces between [] , {} , etc are crucial
# {echo "As"} won't work

# num-args should be 1
[ $# -ne 1 ] && { echo $USAGE; exit 1; }

# only numeric allowed
[[ $1 =~ ^[0-9]+$ ]] || { echo $USAGE; exit 1; }

y=$1

# exactly 4 digits allowed
[ ${#y} -ne 4 ] && { echo $USAGE; exit 1; }

if (( 
	( $y % 400 == 0 ) || 
	(( 
		( $y % 4 == 0 ) && 
		( $y % 100 != 0 )
	))
    ))
then
	echo "Leap"
else
	echo "Not a leap year"
fi


