#! /bin/bash
logdir=/var/log
logfile=${logdir}/nginx_install.log
exec >> $logfile 2>&1
sudo yum install nginx -y
sudo systemctl start nginx