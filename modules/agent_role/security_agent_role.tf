data "template_file" "trust" {
  template = file("${path.module}/json/trust.json")

  vars = {
    prefix     = var.prefix
    account_id = var.account_id
  }
}

resource "aws_iam_role" "cst_security_agent_role" {
  name = "${var.prefix}_CstSecurityAgentRole"

  assume_role_policy = data.template_file.trust.rendered
}
