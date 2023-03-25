
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

resource "aws_subnet" "my-subnet-public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "public-subnet-1a"
  }
}

# Launch subnet  2
resource "aws_subnet" "my-subnet-private" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "private-subnet-1b"
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
    from_port   = 80
    to_port     = 80
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

## associate route table
resource "aws_route_table_association" "my_rt_asso" {
  subnet_id      = aws_subnet.my-subnet-public.id
  route_table_id = aws_route_table.my_route_table.id
}
