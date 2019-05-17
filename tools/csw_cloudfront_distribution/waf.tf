resource "aws_waf_ipset" "cyber_ipset" {
  name = "csw-${var.env}-waf-ipset"

  ip_set_descriptors = ["${module.common_vars.public_ip_set_descriptors}"]
}

resource "aws_waf_rule" "waf_rule" {
  depends_on  = ["aws_waf_ipset.cyber_ipset"]
  name = "csw-${var.env}-waf-rule"
  metric_name = "csw-${var.env}-waf-rule"

  predicates {
    data_id = "${aws_waf_ipset.cyber_ipset.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "waf_acl" {
  depends_on  = ["aws_waf_ipset.cyber_ipset", "aws_waf_rule.waf_rule"]
  name        = "csw-${var.env}-waf-acl"
  metric_name = "csw-${var.env}-waf-acl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.waf_rule.id}"
    type     = "REGULAR"
  }
}