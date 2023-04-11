terraform {
backend "s3" {
encrypt = true
bucket = "mybucket-terraform-state"
key = "project/terraform.tfstate"
region = "us-east-1"
dynamodb_table = "terraform-statetable"
}
}

