variable "prefix" {}
variable "password" {}

variable "private_subnet_cidr_blocks" {
  type = list
}

variable "private_subnet_ids" {
  type = list
}

variable "public_security_group_id" {}
variable "vpc_id" {}

variable "rds_instance_type" {
  default = "db.t2.small"
}
