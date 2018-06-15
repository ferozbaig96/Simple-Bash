#/bin/bash
# menu-select.sh

# Script to display a menu via which user can select an item for processing

echo "Starting"

select FILENAME in *
do
	echo "You selected $FILENAME ($REPLY)"
	#cat $FILENAME
	break;
done

echo "Ending"
