
# string type
# var.region // call in code
variable "region" {
    type = string
    default = "us-east-1"
     description = "aws region"
}

# without argument varialbe
variable "ingress_port" {
  type = number
  default = 80
  #sensitive = true
}

# map varialbe 
# define in code 
#var.instance_type.small
variable "instance_type" {
    type =map(string)
    default = {
        small = "t2.micro"
        medium = "t2.small"
        large = "t2.large"
    }
}

# List varialbe define [0,1,2,3]
# var.availablity_zone.0

variable "availablity_zone" {
    type= list(string)
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}

# for instance ami
variable "instance_ami" {
    type = string
    default = "ami-0c9978668f8d55984"
  
}

# cidr block 
variable "cidr_block" {
    type = string
    default = "10.0.1.0/24"
}
  
  # bool type varialbe
  
variable "map_public_ip_on_launch" {
    type = bool
    default = true
}


# for locals value 

variable "company_name" {
    type = string
    default = "pagecloud"
  
}

variable "project_name" {
    type = string
    default = "terraform"  
}

variable "project_code" {
    type = string
    default = "2023-03"
  }

  variable "cost_center" {
    type = string
    default = "10101"
    
  }

  variable "team" {
    default= "DEV"
    
  }

  variable "department" {
    default = "technology"
    
  }