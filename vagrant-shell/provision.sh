#!/usr/bin/env bash

# Enable provisioning of the client with a shell script.
echo "Entering Shell Provisoning"

yum makecache fast
yum install deltarpm --assumeyes
yum install wget --assumeyes

/bin/mv /etc/yum.repos.d/public-yum-ol7.repo /etc/yum.repos.d/public-yum-ol7.repo.orig
wget -q http://yum.oracle.com/public-yum-ol7.repo -P /etc/yum.repos.d

yum install yum-utils --assumeyes
yum-config-manager --enable ol7_addons
yum-config-manager --enable ol7_software_collections
yum-config-manager --enable ol7_developer
yum-config-manager --enable ol7_developer_EPEL

yum makecache fast

echo " "
ip addr show

date +"%F %T" > /etc/git-creation-timestamp.txt
cat /etc/git-creation-timestamp.txt
echo "Exiting Shell Provisoning"
echo " "
