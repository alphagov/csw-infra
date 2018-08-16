resource "aws_instance" "bastion" {
  ami                         = "${lookup(var.amis, var.region)}"
  availability_zone           = "${var.subnet_zone}"
  instance_type               = "t2.micro"
  key_name                    = "${var.ssh_key_name}"
  vpc_security_group_ids      = ["${var.public_security_group_id}"]
  subnet_id                   = "${var.public_subnet_id}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags {
    Name = "${var.prefix}-bastion"
  }
}
