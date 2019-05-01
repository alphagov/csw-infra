resource "aws_security_group" "public_security_group" {
  name        = "${var.tool}-${var.environment}-sg-public"
  description = "Allow incoming HTTP connections."

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = "${var.gds_public_cidrs}"
  }

  egress {
    from_port = 5432  # Postgres
    to_port   = 5432
    protocol  = "tcp"

    cidr_blocks = [
      "${module.private_subnet_1.private_subnet_cidr_block_out}",
      "${module.private_subnet_2.private_subnet_cidr_block_out}",
    ]
  }

  egress {
    from_port = 22    # Bastion > dev box
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "${module.public_subnet_1.public_subnet_cidr_block_out}",
      "${module.public_subnet_2.public_subnet_cidr_block_out}",
    ]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  vpc_id = "${module.vpc.vpc_id_out}"

  tags {
    Name = "${var.tool}-${var.environment}-sg-public"
  }
}
