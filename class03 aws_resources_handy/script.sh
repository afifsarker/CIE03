#! /bin/bash
logdir=/var/log
logfile=${logdir}/nginx_install-4.log
exec >> $logfile 2>&1
sudo yum install nginx -y
sudo echo 'this is deployed via terraform' > /usr/share/nginx/html/index.html
sudo service nginx restart
sudo chkconfig nginx on
sudo touch /home/ec2-user/script-3.txt
sudo mkdir /tmp/byterraform-3
cd /tmp
sudo chmod -R 707 byterraform-3
sudo touch copy.txt
sudo cp copy.txt /home/ec2-user/