# lauch EC2 as web server 

resource "aws_instance" "web-server-1" {
  ami                    = "ami-0c9978668f8d55984"  #for rhel9 image
  #ami                     = var.instance_ami
  instance_type          = var.instance_type.small
  subnet_id              = aws_subnet.my-subnet-public-1.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  
  tags = { 
   Name= "web-server-1"
  }
  
  key_name = "terraform"
  #user_data =  file("script.sh")        //using script
  user_data = <<EOF
#! /bin/bash
sudo yum install httpd -y
echo 'this is from web-server-1' > /var/www/html/index.html
sudo systemctl start httpd
EOF
}
#check# 


# web server 2
resource "aws_instance" "web-server-2" {
  ami                    = "ami-0c9978668f8d55984"  #for rhel9 image
  #ami                     = var.instance_ami
  instance_type          = var.instance_type.small
  subnet_id              = aws_subnet.my-subnet-public-2.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  
  tags = { 
   Name= "web-server-2"
  }
  
  key_name = "terraform"
  #user_data =  file("script.sh")        //using script
  user_data = <<EOF
#! /bin/bash
sudo yum install httpd -y
echo 'this is from web-server-2' > /var/www/html/index.html
sudo systemctl start httpd
EOF
}
