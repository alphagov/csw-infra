module "bastion" {
  source                   = "../bastion"
  vpc_id                   = "${var.vpc_id}"
  prefix                   = "${var.prefix}"
  region                   = "${var.region}"
  subnet_zone              = "${var.subnet_zone}"
  subnet_cidr_block        = "${var.subnet_cidr_block}"
  ssh_key_name             = "${var.ssh_key_name}"
  ssh_public_key_path      = "${var.ssh_public_key_path}"
  public_security_group_id = "${var.public_security_group_id}"
  public_subnet_id         = "${aws_subnet.subnet.id}"
  amis                     = "${var.amis}"
}
