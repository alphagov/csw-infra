variable "vpc_id" {}
variable "igw_id" {}
variable "prefix" {}
variable "region" {}

variable "subnet_zone" {}
variable "subnet_cidr_block" {}

variable "ssh_key_name" {}
variable "ssh_public_key_path" {}
variable "public_security_group_id" {}

variable "amis" {
  type = "map"
}
