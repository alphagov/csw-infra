variable "availability_zones" {
  type = "list"
}

variable "postgres_root_password" {}
variable "ssh_key_name" {}
variable "ssh_public_key_path" {}

variable "tool" {
  default = "csw"
}

variable "environment" {}
variable "host_account_id" {}

variable "ip_16bit_prefix" {
  description = "Each VPC is created with a /16 bit mask meaning that if whilst they don't need to be addressable we should be able to keep all the internal IPs unique"
  default     = "10.1"
}

variable "prefix" {
  description = "Prefix all named resources"
  default     = "csw-test"
}

variable "region" {
  description = "EC2 Region for the VPC"
  default     = "eu-west-2"
}

variable "amis" {
  description = "AMIs by region"

  default = {
    eu-west-2 = "ami-6b3fd60c" # Ubuntu Server 16.04 LTS (HVM), SSD Volume Type
  }
}

variable "gds_public_cidrs" {
  description = "GDS public IP addresses"

  default = [
    "213.86.153.212/32",
    "213.86.153.213/32",
    "213.86.153.214/32",
    "213.86.153.235/32",
    "213.86.153.236/32",
    "213.86.153.237/32",
    "85.133.67.244/32",
  ]
}
