# lauch EC2 as web server 

resource "aws_instance" "web_server" {
  #ami                    = "ami-0c9978668f8d55984"  #for rhel9 image
  ami                     = var.instance_ami
  instance_type          = var.instance_type.small
  subnet_id              = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  
  tags = {                       //define local tab name 
    Name = local.common_tags.resource_name
        #Name = "pagecloud-terraform-10101-2023-03"
  }
  
  key_name = "terraform"
  #user_data =  file("script.sh")        //using script
  user_data = <<EOF
#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
EOF
}
#check# 

# import resources from others network

resource "aws_instance" "import-others-network" {
  ami = "ami-06e46074ae430fba6"
  instance_type = "t2.micro"
  subnet_id             = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "import-others-network-resource"
  }
}


# import exisiting netwrok resources
resource "aws_instance" "import-existing-network" {
  ami = "ami-06e46074ae430fba6"
  instance_type = "t2.micro"
  subnet_id             = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "import-existing-network"
  }
}





/*
# for import ec2 from others vpc/subnet/sg
resource "aws_instance" "import-others-network" {

  ami = "ami-00c39f71452c08778"
  instance_type  = "t2.micro"
  #subnet_id              = aws_subnet.my-subnet-public.id
  #vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    "Name" = "import-others-network"
  }
  key_name = "terraform"
 }


# import ec2 from existing vpc 

resource "aws_instance" "import-existing-network" {
ami = "ami-00c39f71452c08778"
instance_type  = "t2.micro"
 subnet_id              = aws_subnet.my-subnet-public.id
 vpc_security_group_ids = [aws_security_group.my_sg.id]
 tags = {
 "Name" = "import-existing-network"
  }
  key_name = "terraform"

}

*/
