resource "aws_acm_certificate" "cf_cert" {
  domain_name       = "${local.target_url}"
  validation_method = "DNS"

  tags = {
    Environment = "${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}