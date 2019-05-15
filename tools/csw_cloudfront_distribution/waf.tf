resource "aws_waf_ipset" "cyber_ipset" {
  name = "gdsIPSet"

  #ip_set_descriptors = ["${data.terraform_remote_state.common_vars.public_ip_set_descriptors}"]
  template_body = "${data.terraform_remote_state.common_vars.waf_ip_set}"
}

resource "aws_waf_rule" "waf_rule" {
  depends_on  = ["aws_waf_ipset.cyber_ipset"]
  name        = "gdsWAFRule"
  metric_name = "gdsWAFRule"

  predicates {
    data_id = "${aws_waf_ipset.cyber_ipset.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "waf_acl" {
  depends_on  = ["aws_waf_ipset.cyber_ipset", "aws_waf_rule.waf_rule"]
  name        = "tfWebACL"
  metric_name = "tfWebACL"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.waf_rule.id}"
    type     = "REGULAR"
  }
}