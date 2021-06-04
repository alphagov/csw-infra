data "aws_iam_policy_document" "assume-role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals = {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.cd_account}:root"]
    }

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = [var.source_cidrs]
    }
  }
}

data "aws_iam_policy_document" "cd-defaults" {
  statement {
    sid = "1"

    actions = [
      "iam:PassRole",
      "iam:GetRolePolicy",
      "iam:GetRole",
      "iam:GetInstanceProfile",
      "iam:PutRolePolicy"
    ]

    resources = [
      "arn:aws:iam::*:role/csw-*",
      "arn:aws:iam::*:instance-profile/csw-*",
    ]
  }

  statement {
    actions = [
      "apigateway:GET",
      "apigateway:PUT",
      "apigateway:POST",
    ]

    resources = [
      "arn:aws:apigateway:${var.region}::/restapis/*",
    ]
  }

  statement {
    actions = [
      "lambda:List*",
      "lambda:Get*",
      "lambda:Update*",
      "lambda:Delete*",
      "lambda:InvokeFunction",
      "lambda:CreateFunction",
      "lambda:AddPermission",
      "lambda:TagResource"
    ]

    resources = [
      "arn:aws:lambda:${var.region}:*:event-source-mapping:*",
      "arn:aws:lambda:${var.region}:*:function:csw-*",
    ]
  }

  statement {
    actions = [
      "sqs:List*",
      "sqs:Get*",
      "sqs:SetQueueAttributes",
      "sqs:CreateQueue",
    ]

    resources = [
      "arn:aws:sqs:${var.region}:*:csw-*",
    ]
  }

  statement {
    actions = [
      "ec2:Describe*",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:${var.region}:*:log-group:/aws/lambda/csw-*",
    ]
  }

  statement {
    actions = [
      "rds:Describe*",
      "rds:ListTagsForResource",
    ]

    resources = [
      "arn:aws:rds:${var.region}:*:db:csw*",
      "arn:aws:rds:${var.region}:*:subgrp:csw*",
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
  }

  statement {
    actions = [
      "events:Describe*",
      "events:PutRule",
      "events:PutTargets",
      "events:RemoveTargets",
      "events:DeleteRule"
    ]

    resources = [
      "arn:aws:events:${var.region}:*:rule/csw-*",
    ]
  }

  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:PutParameter",
    ]

    resources = [
      "arn:aws:ssm:${var.region}:*:parameter/csw/*",
    ]
  }
}

resource "aws_iam_role" "cd" {
  name               = "cd-cybersecurity-tools-concourse-worker"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role.json}"
}

resource "aws_iam_policy" "cd-defaults" {
  name   = "concourse_policy"
  policy = "${data.aws_iam_policy_document.cd-defaults.json}"
}

resource "aws_iam_policy_attachment" "cd-defaults" {
  name       = "role-policy-attachment"
  roles      = ["${aws_iam_role.cd.name}"]
  policy_arn = "${aws_iam_policy.cd-defaults.arn}"
}
