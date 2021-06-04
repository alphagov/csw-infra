resource "aws_security_group" "rds_security_group" {
  name = "${var.prefix}-rds-security-group"

  description = "${var.prefix} RDS security group"
  vpc_id      = var.vpc_id

  # Only postgres in
  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    cidr_blocks = [var.private_subnet_cidr_blocks]

    security_groups = [
      var.public_security_group_id,
    ]
  }

  tags {
    Name = "${var.prefix}-rds-security-group"
  }
}
