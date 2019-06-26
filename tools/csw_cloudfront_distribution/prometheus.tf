/*
data "terraform_remote_state" "prometheus_state" {
  backend = "s3"
  config {
    bucket  = "gds-security-terraform"
    key     = "terraform/state/account/${data.aws_caller_identity.current.account_id}/service/prometheus.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}
*/