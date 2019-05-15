data "terraform_remote_state" "common_vars" {
  backend = "s3"
  config {
    bucket  = "cyber-security-dns-state"
    key     = "vars/common.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}