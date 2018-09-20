output "role_id" {
  value = "${aws_iam_role.developer_box_role.id}"
}

output "role_name" {
  value = "${aws_iam_role.developer_box_role.name}"
}

output "policy_id" {
  value = "${aws_iam_role_policy.developer_box_role_policy.id}"
}
