# Declare a name for the CloudFront origin and
# the target DNS name for CloudFront
locals {
  cf_origin_id = "csw-${var.env}"
  target_url = "${var.sub_domain}.${var.dns_zone_fqdn}"
}
