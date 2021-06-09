variable "region" {
  description = "EC2 Region for the VPC"
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "bucket for chalice deployment"
}

variable "cd_account" {
  description = "Concourse Account"
}

variable "source_cidrs" {
  description = "Source CIDRs that are allowed to perform the assume role"
  type        = list

  default = [
    "213.86.153.212/32",
    "213.86.153.213/32",
    "213.86.153.214/32",
    "213.86.153.235/32",
    "213.86.153.236/32",
    "213.86.153.237/32",
    "85.133.67.244/32",
    "35.177.118.205/32", #concourse ips
    "3.9.45.234/32",
  ]
}
