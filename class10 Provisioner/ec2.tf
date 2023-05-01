# https://developer.hashicorp.com/terraform/language/resources/provisioners/file

resource "aws_instance" "web_server" {
  ami                    = "ami-0c9978668f8d55984"  #for rhel9 image
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "web_server"
  }
  key_name = "terraform"

# taking connection towards ec2

connection {
  type = "ssh"
  user = "ec2-user"
  private_key = file("./terraform.pem")
  host = self.public_ip
}

# define file privisioner 
# copies local file to remote machine
provisioner "file" {
  source = "fileprovisionercheck.txt"
  destination = "/tmp/fileprovisionercheck.txt"
}

# copies content to remote machine in specific file
provisioner "file" {
content = "we used this AMI: ${self.public_ip}"
destination = "/tmp/fileprovisionercheck.txt" 
}

# copy folder/directory to remote machine 
provisioner "file" {
  source = "carnival"
  destination = "/tmp"    
}

# copy folder/directory content  to remote machine in specific directory
provisioner "file" {
  source = "carnival/"
  destination = "/tmp/carnival"    
}

## define local-exec  provisioner

provisioner "local-exec" {
  command = "echo ${self.public_ip}  > instance_public_ip.txt"
  on_failure = continue
}

provisioner "local-exec" {
  command = "echo ${self.private_ip}  > instance_private_ip.txt"
  on_failure = continue
}

## define remote-exec provisioner
# for shell commands 
provisioner "remote-exec" {
    inline = [ 
        "touch /tmp/remote-exec.txt",
        "cd /tmp",
        "mkdir remote-exec",
        "sleep 5",
        "echo 'we are testing remote-exec provisioner' > /tmp/remote-exec.txt",
     ]
  
}

# remote exec for shell script executions
provisioner "remote-exec" {
script = "./install_http.sh"
#script_path = "/home/ec2-user/install_http.sh"
} 

 } // closing ec2 block