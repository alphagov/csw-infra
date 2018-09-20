data "template_file" "trust" {
  template = "${file("${path.module}/json/trust.json")}"

  vars {
    prefix          = "${var.prefix}"
    region          = "${var.region}"
    account_id      = "${var.account_id}"
  }
}

resource "aws_iam_role" "developer_box_role" {
  name = "${var.prefix}_DeveloperBoxRole"

  assume_role_policy = "${data.template_file.trust.rendered}"
}
