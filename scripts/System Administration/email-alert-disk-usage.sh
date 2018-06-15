#/bin/bash
# email-alert-disk-usage.sh : Alert via email when disk usage > specified threshold

# should be used as a cronjob

THRESHOLD=90
PART="sda2"
EMAIL="john@doe.com"

# cut with delimeter "%" and take the field 1
USAGE=`df -h | grep $PART | awk '{print $5}' | cut -d "%" -f 1`

# -ge greater or equal
if [ $USAGE -ge $THRESHOLD ]
then
	# mailutils must be installed for mail command
	echo "Disk usage : $USAGE %" | mail -s "ALERT! Running out of disk space" $EMAIL
fi


