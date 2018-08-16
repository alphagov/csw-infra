variable "prefix" {}
variable "environment" {}
variable "tool" {}

variable "vpc_cidr_block" {
  description = "CIDR for the whole VPC"
  default     = "10.1.0.0/16"
}
