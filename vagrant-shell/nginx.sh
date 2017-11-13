#!/usr/bin/env bash

# Enable provisioning of the client with a shell script.
echo "Entering Nginx Provisoning"

touch /etc/yum.repos.d/nginx.repo

cat << EOF >> /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/rhel/7/x86_64/
gpgcheck=0
enabled=1
EOF

yum -q -y makecache fast

yum -q -y install nginx

sed -i 's/Welcome/'"$HOSTNAME"' \- Welcome/' /usr/share/nginx/html/index.html

systemctl enable nginx.service
systemctl start nginx.service

date +"%F %T"
echo "Exiting Nginx Provisoning"
echo " "
