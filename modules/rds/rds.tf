variable "regex" {
  default = "/[^0-9]/"
}

variable "replace" {
  default = ""
}

resource "aws_db_instance" "rds" {
  allocated_storage         = 16                                                                                   # gigabytes
  backup_retention_period   = 7                                                                                    # in days
  db_subnet_group_name      = "${aws_db_subnet_group.rds_subnet_group.name}"
  engine                    = "postgres"
  engine_version            = "9.5"
  identifier                = "${var.prefix}-postgres"
  instance_class            = "${var.rds_instance_type}"
  multi_az                  = false
  name                      = "${var.prefix}Postgres"
  final_snapshot_identifier = "${var.prefix}Postgres-${replace(timestamp(),var.regex,var.replace)}-final-snapshot"
  username                  = "root"
  password                  = "${var.password}"
  port                      = 5432
  publicly_accessible       = false
  storage_encrypted         = true                                                                                 # you should always do this
  storage_type              = "gp2"
  vpc_security_group_ids    = ["${aws_security_group.rds_security_group.id}"]
  apply_immediately         = true

  tags {
    Name = "${var.prefix}-rds"
  }
}
