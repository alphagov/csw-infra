resource "aws_route53_record" "csw_cname" {
  zone_id = "${data.terraform_remote_state.dns_zone.zone_id}"
  name    = "${var.sub_domain}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.cf_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cf_distribution.hosted_zone_id}"
    evaluate_target_health = true
  }
}
