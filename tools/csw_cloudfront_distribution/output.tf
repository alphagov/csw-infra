output "acm_certificate_arn" {
  value = "${aws_acm_certificate.cf_cert.arn}"
}

output "acm_certificate_dns_validation_options" {
  value = "${aws_acm_certificate.cf_cert.domain_validation_options}"
}

output "target_url" {
  value = "${local.target_url}"
}

output "waf_acl_id" {
  value = "${aws_waf_web_acl.waf_acl.id}"
}