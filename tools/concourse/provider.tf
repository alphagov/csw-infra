##
# Setting region to stop Terraform prompting

provider "aws" {
  region = "${var.region}"
}
