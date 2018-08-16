module "vpc" {
  source         = "../../modules/vpc/"
  environment    = "${var.environment}"
  tool           = "${var.tool}"
  prefix         = "${var.tool}-${var.environment}"
  vpc_cidr_block = "${var.ip_16bit_prefix}.0.0/16"
}

module "public_subnet_1" {
  source            = "../../modules/public_subnet/"
  vpc_id            = "${module.vpc.vpc_id_out}"
  prefix            = "${var.tool}-${var.environment}"
  igw_id            = "${module.vpc.igw_id_out}"
  subnet_zone       = "${var.region}a"
  subnet_cidr_block = "${var.ip_16bit_prefix}.1.0/24"
}

module "public_subnet_2" {
  source            = "../../modules/public_subnet/"
  vpc_id            = "${module.vpc.vpc_id_out}"
  prefix            = "${var.tool}-${var.environment}"
  igw_id            = "${module.vpc.igw_id_out}"
  subnet_zone       = "${var.region}b"
  subnet_cidr_block = "${var.ip_16bit_prefix}.2.0/24"
}

module "private_subnet_1" {
  source            = "../../modules/private_subnet/"
  vpc_id            = "${module.vpc.vpc_id_out}"
  prefix            = "${var.tool}-${var.environment}"
  subnet_zone       = "${var.region}a"
  subnet_cidr_block = "${var.ip_16bit_prefix}.3.0/24"
}

module "private_subnet_2" {
  source            = "../../modules/private_subnet/"
  vpc_id            = "${module.vpc.vpc_id_out}"
  prefix            = "${var.tool}-${var.environment}"
  subnet_zone       = "${var.region}b"
  subnet_cidr_block = "${var.ip_16bit_prefix}.4.0/24"
}

module "jump_subnet" {
  source                   = "../../modules/jump_subnet/"
  vpc_id                   = "${module.vpc.vpc_id_out}"
  region                   = "${var.region}"
  amis                     = "${var.amis}"
  igw_id                   = "${module.vpc.igw_id_out}"
  prefix                   = "${var.tool}-${var.environment}"
  subnet_zone              = "${var.region}c"
  subnet_cidr_block        = "${var.ip_16bit_prefix}.5.0/24"
  ssh_key_name             = "${var.ssh_key_name}"
  ssh_public_key_path      = "${var.ssh_public_key_path}"
  public_security_group_id = "${aws_security_group.public_security_group.id}"
}

module "rds" {
  source   = "../../modules/rds/"
  vpc_id   = "${module.vpc.vpc_id_out}"
  prefix   = "${var.tool}${var.environment}"
  password = "${var.postgres_root_password}"

  private_subnet_cidr_blocks = [
    "${module.private_subnet_1.private_subnet_cidr_block_out}",
    "${module.private_subnet_2.private_subnet_cidr_block_out}",
  ]

  private_subnet_ids = [
    "${module.private_subnet_1.private_subnet_id_out}",
    "${module.private_subnet_2.private_subnet_id_out}",
  ]

  public_security_group_id = "${aws_security_group.public_security_group.id}"
}
