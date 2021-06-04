resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.prefix}_igw"
    Tool        = var.tool
    Environment = var.environment
  }
}
