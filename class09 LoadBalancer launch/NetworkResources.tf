
#launch vpc

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "my_created_vpc"
  }
}

# Launch subnet 

resource "aws_subnet" "my-subnet-public-1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.cidr_block
  availability_zone       = var.availablity_zone.0
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "public-subnet-1a"
  }
}

# Launch subnet  2
resource "aws_subnet" "my-subnet-public-2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "public-subnet-1b"
  }
}


# ## launch security group
resource "aws_security_group" "my_sg" {
  description = "my_sg_trafic"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "my_created_sg"
  }

  ingress {
    description = "80 port allow"
    from_port   = var.ingress_port
    to_port     = var.ingress_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "22 port allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


## create igw
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_created_igw"
  }
}


## launch route table

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_created_rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

## associate route table 1
resource "aws_route_table_association" "my_rt_asso-1" {
  subnet_id      = aws_subnet.my-subnet-public-1.id
  route_table_id = aws_route_table.my_route_table.id
}

## associate route table 2
resource "aws_route_table_association" "my_rt_asso-2" {
  subnet_id      = aws_subnet.my-subnet-public-2.id
  route_table_id = aws_route_table.my_route_table.id
}
