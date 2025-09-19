resource "aws_sqs_queue" "sfd_queue" {
  name = var.queue_name
  message_retention_seconds = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
}