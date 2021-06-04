output "role_id" {
  value = aws_iam_role.cst_security_agent_role.id
}

output "policy_id" {
  value = ws_iam_role_policy.cst_security_agent_role_policy.id
}
