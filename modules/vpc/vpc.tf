resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr_block}"

  enable_dns_hostnames = false

  ## enable_dns_support to be set to false once we have our own resolvers
  enable_dns_support = true

  tags {
    Name        = "${var.prefix}_vpc"
    Tool        = "${var.tool}"
    Environment = "${var.environment}"
  }
}
