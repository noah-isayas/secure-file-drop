output "queue_arn" {
  value = aws_sqs_queue.sfd_queue.arn
}
output "queue_url" {
  value = aws_sqs_queue.sfd_queue.url
  
}