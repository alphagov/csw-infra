resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "${var.prefix}_rds_subnet_group"

  subnet_ids = [var.private_subnet_ids]

  tags {
    Name = "${var.prefix}-rds-subnet-group"
  }
}
