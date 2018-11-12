resource "aws_security_group" "developer_security_group" {
  name        = "${var.tool}-${var.environment}-sg-developer"
  description = "Allow incoming HTTP connections."

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
        "${var.ip_16bit_prefix}.0.0/16"
    ]
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
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  vpc_id = "${module.vpc.vpc_id_out}"

  tags {
    Name = "${var.tool}-${var.environment}-sg-developer"
  }
}

module "developer_box_role" {
  source            = "../../modules/developer_box_role"
  prefix            = "${var.prefix}"
  environment       = "${var.environment}"
  region            = "${var.region}"
  bucket_name       = "${var.bucket_name}"
  account_id        = "${var.host_account_id}"
}

resource "aws_iam_instance_profile" "developer_box_instance_profile" {
  name = "${var.prefix}-developer_box_instance_profile"
  role = "${module.developer_box_role.role_name}"
}

resource "aws_instance" "developer" {
  ami                         = "${lookup(var.amis, var.region)}"
  availability_zone           = "${var.region}a"
  instance_type               = "t2.micro"
  key_name                    = "${var.ssh_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.developer_security_group.id}"]
  subnet_id                   = "${module.public_subnet_1.public_subnet_id_out}"
  associate_public_ip_address = false
  source_dest_check           = false
  iam_instance_profile        = "${aws_iam_instance_profile.developer_box_instance_profile.name}"

  tags {
    Name = "${var.environment}-developer"
  }
}



