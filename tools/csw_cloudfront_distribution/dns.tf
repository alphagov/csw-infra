resource "aws_route53_record" "csw_cname" {
  zone_id = "${data.terraform_remote_state.dns_zone.zone_id}"
  name    = "${var.sub_domain}"
  type    = "CNAME"
  ttl     = "30"

  records = [
    "${var.api_gateway_url}"
  ]
}
