#/bin/bash
# server-health.sh : report server related information

echo -e "Date \t: `date`"
echo -e "Uptime \t: `uptime`"
echo -e "--------------------\n"

echo "Curently connected:"
w
echo -e "--------------------\n"

echo "Last 5 logins:"
last -a | head -5
echo -e "--------------------\n"

echo "Disk & memory usage:"
PART="sda2"
df -h | grep "$PART" | awk '{print "Free/total disk \t: " $4 " / " $2}'
free -m | xargs | awk '{print "Free/total memory \t: " $10 " / " $8 " MB"}'
echo -e "--------------------\n"
