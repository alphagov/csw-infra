resource "aws_sqs_queue" "audit_account_queue" {
  name = "${var.tool}-${var.environment}-audit-account-queue"
  delay_seconds             = 5
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue" "audit_account_metric_queue" {
  name = "${var.tool}-${var.environment}-audit-account-metric-queue"
  delay_seconds             = 5
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue" "evaluated_metric_queue" {
  name = "${var.tool}-${var.environment}-evaluated-metric-queue"
  delay_seconds             = 5
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue" "completed_audit_queue" {
  name = "${var.tool}-${var.environment}-completed-audit-queue"
  delay_seconds             = 5
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue" "failed_metric_queue" {
  name = "${var.tool}-${var.environment}-failed-metric-queue"
  delay_seconds             = 5
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue" "failed_audit_queue" {
  name = "${var.tool}-${var.environment}-failed-audit-queue"
  delay_seconds             = 5
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}