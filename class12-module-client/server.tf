
/*
  #subnet_id              = aws_subnet.my-subnet-public.id
  #vpc_security_group_ids = [aws_security_group.my_sg.id]


EX: 
module <module_name> {
source = ""
}

*/

module "instance_ready" {
source = "../class12-modules/ec2"
  instance_type = "t2.large"
  #subnet_id = "aws_subnet.my-subnet-private.id"
}

