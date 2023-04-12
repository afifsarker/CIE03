/*
# required resources below to launch a aws ALB

2. aws_lb
3. aws_lb_target_group
4. aws_lb_listener
5. Aws_lb_target_group_attachment
*/


# launch ALB 

resource "aws_lb" "MyALB" {
    name = "MyALB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.my_sg.id]
    subnets = [aws_subnet.my-subnet-public-1.id,aws_subnet.my-subnet-public-2.id]
    enable_deletion_protection = false
    tags = {
        Name = "MyALB"
    }
}

# launch aws_lb_target_group
resource "aws_lb_target_group" "MyTargetGroup" {
    name = "lb-terget-group"
    port  = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      "Name" = "MyTargetGroup"
    }
  
}

# launch aws_lb_listener 
resource "aws_lb_listener" "My-lb-listener" {
  load_balancer_arn = aws_lb.MyALB.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.MyTargetGroup.arn
  }
  tags = {
    "Name" = "My-lb-listener"
  }
}

# launch Aws_lb_target_group_attachment -1 
resource "aws_lb_target_group_attachment" "ins-1" {
  target_group_arn = aws_lb_target_group.MyTargetGroup.arn
  target_id = aws_instance.web-server-1.id
  port = 80
}

# launch Aws_lb_target_group_attachment -2

resource "aws_lb_target_group_attachment" "ins-2" {
  target_group_arn = aws_lb_target_group.MyTargetGroup.arn
  target_id = aws_instance.web-server-2.id
  port = 80
}


# workspace
# module
# provissioner
# cloud funda