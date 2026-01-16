variable "aws_region" {

description = "AWS region where resource will be provisioned"
default = "eu-west-1"

}

variable "ami_id" {

description = "ami ID for ubuntu, but we are not using this ami id, will be using from data"
default = "ami-049442a6cf8319180" 

}


variable "instance_type" {

description = "Type of the instance to be provisioned"
default = "t2.medium"

}

variable "my_environment" {

description = "Environment where resource to be provisioned"
default = "dev"

}
