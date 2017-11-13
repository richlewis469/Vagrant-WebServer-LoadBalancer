#!/usr/bin/env bash

# Enable provisioning of the client with a shell script.
echo "Entering Nginx-LoadBalancer Provisoning"

mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

cat << EOF >> /etc/nginx/nginx.conf
user  nginx;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {
    worker_connections  1024;
}
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile        on;
    keepalive_timeout  65;
    upstream backend {
        server 192.168.56.3;
        server 192.168.56.4;
        server 192.168.56.5;
        server 192.168.56.6;
        server 192.168.56.7;
    }
    server {
        listen       80;
        server_name  localhost;
        location / {
            proxy_pass http://backend;
        }
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }
    }
}
EOF

systemctl restart nginx.service

date +"%F %T"
echo "Exiting Nginx-LoadBalancer Provisoning"
echo " "
