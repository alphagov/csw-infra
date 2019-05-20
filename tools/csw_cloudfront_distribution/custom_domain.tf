locals {
  api_gatway_url_components = "${split("/",var.api_gateway_url)}"
  api_gateway_id            = "${local.api_gatway_url_components[2]}"
  api_gateway_domain        = "${join("",slice(local.api_gatway_url_components,2,3))}"
  api_gateway_path          = "/${join("/",compact(slice(local.api_gatway_url_components,3,length(local.api_gatway_url_components))))}"
  api_gateway_stage         = "${join("/",compact(slice(local.api_gatway_url_components,3,length(local.api_gatway_url_components))))}"
}

data "aws_api_gateway_resource" "api" {
  rest_api_id = "${local.api_gateway_id}"
  path        = "${local.api_gateway_path}"
}

resource "aws_api_gateway_domain_name" "domain" {
  certificate_arn = "${aws_acm_certificate.cf_cert.arn}"
  domain_name     = "${local.target_url}"
}

resource "aws_api_gateway_base_path_mapping" "mapping" {
  api_id      = "${local.api_gateway_id}"
  stage_name  = "${local.api_gateway_stage}"
  domain_name = "${local.target_url}"
}

resource "aws_route53_record" "example" {
  zone_id = "${data.terraform_remote_state.dns_zone.zone_id}"
  name    = "${var.sub_domain}"
  type    = "CNAME"

  records = [
    "${local.api_gateway_domain}"
  ]
  /*
  alias {
    evaluate_target_health = true
    name                   = "${aws_api_gateway_domain_name.example.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.example.cloudfront_zone_id}"
  }
  */
}