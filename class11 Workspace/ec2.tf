
# terraform workspace list -- > workspace list
# terraform workspace show  -- > used workspace show
# terraform workspace new dev -- > workspace create with name dev
# terraform workspace select dev -- > workspace select/swith
/*
resource "aws_instance" "web_server" {
  ami                    = "ami-0c9978668f8d55984"  #for rhel9 image
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "web_server-dev"
  }
  key_name = "terraform"
}
*/

## demonastrate resource counte syntax 
/*
resource "aws_instance" "web_server" {
  ami  = "ami-0c9978668f8d55984"  #for rhel9 image
  instance_type   = "t2.micro"
  subnet_id              = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  count = 3
  tags = {
   Name = "web_server-${count.index}"
  }
key_name = "terraform"
  
}
*/

#Referencing name: 
#web_server-0
#web_server-2
#web_server-2

# launch resources in multiple region with same code

# for default first region
resource "aws_instance" "web_server-vir" {
  ami                    = "ami-0c9978668f8d55984"  #for rhel9 image
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "web_server-virginia"
  }
  key_name = "terraform"
}

# for 2nd region
resource "aws_instance" "web_server-cal" {
  ami                    = "ami-0127b2e6f3b9b94d5"  #for rhel9 image fro california region
  instance_type          = "t2.micro"
  #subnet_id              = aws_subnet.my-subnet-public.id
  #vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "web_server-california"
  }
  provider = aws.california
}

/*
# define null resource in TF

resource "aws_instance" "ec2_example" {
  ami           = "ami-0767046d1677be5a0"
  instance_type =  "t2.micro"
  tags = {
    Name = "Terraform EC2 "
  }
}

resource "null_resource" "null_resource_with_remote_exec" {

  triggers = {
    id = aws_instance.ec2_example.id
  }
  
  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  
  connection {
    type        = "ssh"
    host        = ec2_example.id
    user        = "ubuntu"
    private_key = file("/home/rahul/Jhooq/keys/aws/aws_key")
    timeout     = "4m"
  }

}
*/