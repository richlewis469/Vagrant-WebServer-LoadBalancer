#!/usr/bin/env bash

# Enable provisioning of the client with a shell script.
echo "Entering Shell Provisoning"
yum -q -y makecache fast

echo " "
ip addr show

date +"%F %T" > /etc/git-creation-timestamp.txt
cat /etc/git-creation-timestamp.txt
echo "Exiting Shell Provisoning"
echo " "
