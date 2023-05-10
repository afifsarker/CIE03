resource "aws_instance" "web_server" {
  ami                    = "${var.ami}"  #for rhel9 image
  instance_type          = "${var.instance_type}"
  subnet_id              = aws_subnet.my-subnet-public.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
}

