# lauch EC2 as web server 

resource "aws_instance" "web_server" {
  ami                    = "ami-0c9978668f8d55984"  #for rhel9 image
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "nginx"
  }
  key_name = "terraform"
  user_data_replace_on_change = "true"
  #user_data =  file("script.sh")        //using script
  user_data = <<EOF
#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
EOF
}
#check