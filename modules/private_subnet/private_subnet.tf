/*
  Private Subnet
*/

/* eu-west-2a */
resource "aws_subnet" "private_subnet" {
  vpc_id = var.vpc_id

  cidr_block        = var.subnet_cidr_block
  availability_zone = var.subnet_zone

  tags = {
    Name = "${var.prefix}-private-subnet-${var.subnet_zone}"
  }
}
