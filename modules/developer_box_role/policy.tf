data "template_file" "policy" {
  template = "${file("${path.module}/json/policy.json")}"

  vars {
    prefix      = "${var.prefix}"
    region      = "${var.region}"
    account_id  = "${var.account_id}"
    bucket_name = "${var.bucket_name}"
  }
}

resource "aws_iam_role_policy" "developer_box_role_policy" {
  name = "${var.prefix}_DeveloperBoxRolePolicy"
  role = "${aws_iam_role.developer_box_role.id}"

  policy = "${data.template_file.policy.rendered}"
}
