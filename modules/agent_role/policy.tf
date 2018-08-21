data "template_file" "policy" {
  template = "${file("${path.module}/json/policy.json")}"

  vars {
    prefix     = "${var.prefix}"
    account_id = "${var.account_id}"
  }
}

resource "aws_iam_role_policy" "cst_security_agent_role_policy" {
  name = "${var.prefix}_CstSecurityAgentRolePolicy"
  role = "${aws_iam_role.cst_security_agent_role.id}"

  policy = "${data.template_file.policy.rendered}"
}
