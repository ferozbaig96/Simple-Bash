#/bin/bash
# isroot.sh

# Script to check if the user executing this script has root priveleges

[ `whoami` == "root" ] && (echo "You are root");

# OR

[ $(id -u) -eq 0 ] && (echo "You are root");
