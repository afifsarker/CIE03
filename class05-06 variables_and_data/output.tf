
# define output value
output "instance_public_ip" {
value = aws_instance.web_server.public_ip
description = "instance public IP"  
}

# get private ip of instance

output "instance_private_ip" {
  value = aws_instance.web_server.private_ip
  description = "private ip"
}

# define output value
output "instance_dns" {
value = aws_instance.web_server.public_dns
description = "instance public IP"  
}


# bulk public ip from instance
#output "instance_ips" {
 #   value = aws_instance.web_server.*.public_ip
#}

# take vpc ip
output  "vpc_id" {
    value   = aws_vpc.my_vpc.id
}

