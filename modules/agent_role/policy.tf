data "template_file" "policy" {
  template = file("${path.module}/json/policy.json")

  vars {
    prefix           = var.prefix
    environment      = var.environment
    region           = var.region
    account_id       = var.account_id
    chain_account_id = var.chain_account_id
    chain_role_name  = var.chain_role_name
  }
}

resource "aws_iam_role_policy" "cst_security_agent_role_policy" {
  name = "${var.prefix}_CstSecurityAgentRolePolicy"
  role = aws_iam_role.cst_security_agent_role.id

  policy = data.template_file.policy.rendered
}
