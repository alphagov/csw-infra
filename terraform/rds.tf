resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "${var.prefix}_rds_subnet_group"
  subnet_ids = [
    "${aws_subnet.eu-west-2a-private.id}",
    "${aws_subnet.eu-west-2b-private.id}"
  ]
}

resource "aws_security_group" "rds_security_group" {
  name = "${var.prefix}-rds-security-group"

  description = "${var.prefix} RDS security group"
  vpc_id = "${aws_vpc.default.id}"

  # Only postgres in
  ingress {
    from_port = 0
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [
      "${var.private_subnet_2a_cidr}",
      "${var.private_subnet_2b_cidr}"
    ],
    security_groups = [
      "${aws_security_group.sg-public.id}"
    ]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = [
      "${var.private_subnet_2a_cidr}",
      "${var.private_subnet_2b_cidr}"
    ]
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage        = 16 # gigabytes
  backup_retention_period  = 7   # in days
  db_subnet_group_name   = "${aws_db_subnet_group.rds_subnet_group.name}"
  engine                   = "postgres"
  engine_version           = "9.5.4"
  identifier               = "${var.prefix}-postgres"
  instance_class           = "db.t2.micro"
  multi_az                 = false
  name                     = "${var.prefix}Postgres"
  username                 = "root"
  password                 = "${trimspace(file("${path.module}/secrets/rds-root-password.txt"))}"
  port                     = 5432
  publicly_accessible      = false
  storage_encrypted        = false # you should always do this
  storage_type             = "gp2"
  vpc_security_group_ids   = ["${aws_security_group.rds_security_group.id}"]
}