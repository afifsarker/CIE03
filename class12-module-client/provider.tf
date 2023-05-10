
# for fist region 
provider "aws" {
    region= "us-east-1"
}

# for 2nd region
provider "aws" {
    region = "us-west-1"
    alias = "california"
  
}



terraform {
required_providers {
aws = {
source = "hashicorp/aws"
#version = "5.0"
version = "~>4.0"
#for upgrade version use terraform init -upgrade
}
}
}


