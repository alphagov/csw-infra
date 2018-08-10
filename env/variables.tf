variable "aws_key_path" {}
variable "aws_key_name" {}

variable "prefix" {
    description = "Prefix all named resources"
    default = "<env name>"
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "eu-west-2"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        eu-west-2 = "ami-6b3fd60c" # Ubuntu Server 16.04 LTS (HVM), SSD Volume Type
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.x.0.0/16"
}

variable "public_subnet_2a_cidr" {
    description = "CIDR for the Public Subnet 2a"
    default = "10.x.1.0/24"
}

variable "private_subnet_2a_cidr" {
    description = "CIDR for the Private Subnet 2a"
    default = "10.x.2.0/24"
}

variable "public_subnet_2b_cidr" {
    description = "CIDR for the Public Subnet 2b"
    default = "10.x.3.0/24"
}

variable "private_subnet_2b_cidr" {
    description = "CIDR for the Private Subnet 2b"
    default = "10.x.4.0/24"
}
