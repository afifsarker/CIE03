#!/bin/bash
sudo yum install httpd -y
sudo echo 'manager by remote-exec instance public ip: ${self.public_ip}' > /var/www/html/index.html
sudo systemctl start httpd  