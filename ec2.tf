# lauch EC2 as web server 

resource "aws_instance" "web_server" {
  ami                    = "ami-0ff8a91507f77f867"  #for amazon linux
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "nginx-web"
  }
  key_name = "terraform"
  user_data = <<EOF
#! /bin/bash
sudo yum install nginx -y
sudo service nginx start 
EOF
}
#check