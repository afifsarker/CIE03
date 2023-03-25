#! /bin/bash
logdir=/var/log
logfile=${logdir}/nginx_install.log
exec >> $logfile 2>&1
sudo yum install nginx -y
sudo echo 'deployed by terraform' > /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
