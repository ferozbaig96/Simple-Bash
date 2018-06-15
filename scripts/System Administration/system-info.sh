#/bin/bash
# system-info.sh : Prints the system information

write_header(){
	echo "--------------------------------"
	echo "$@"
	echo "--------------------------------"
}

check_root(){
	if [ `id -u` -ne 0 ]
	then
		return 99
	else
		return 0
	fi 
}

echo -e "Hostname \t: `hostname`"
date

write_header "Linux Distro"
# -m : machine hardware (x64 or x86)
# -r : kernel release version
# -s : kernel name (eg. Linux)
echo -e "Linux kernel \t: `uname -mrs`"
echo

write_header "PCI Devices"
lspci
echo

write_header "Hardware"
# Must have root privileges to run this
check_root
case $? in
	0 )	lshw;;
	* )	echo "You need root privileges to access this";;
esac

#if [ $? -eq 99 ]
#then
#	echo "You need root privileges to access this"
#else
#	lshw
#fi

echo

write_header "CPU Architecture information"
lscpu
echo





