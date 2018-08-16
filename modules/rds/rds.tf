resource "aws_db_instance" "rds" {
  allocated_storage         = 16                                              # gigabytes
  backup_retention_period   = 7                                               # in days
  db_subnet_group_name      = "${aws_db_subnet_group.rds_subnet_group.name}"
  engine                    = "postgres"
  engine_version            = "9.5.4"
  identifier                = "${var.prefix}-postgres"
  instance_class            = "db.t2.micro"
  multi_az                  = false
  name                      = "${var.prefix}Postgres"
  final_snapshot_identifier = "${var.prefix}Postgres-final-snapshot"
  username                  = "root"
  password                  = "${var.password}"
  port                      = 5432
  publicly_accessible       = false
  storage_encrypted         = false                                           # you should always do this
  storage_type              = "gp2"
  vpc_security_group_ids    = ["${aws_security_group.rds_security_group.id}"]

  tags {
    Name = "${var.prefix}-rds"
  }
}
