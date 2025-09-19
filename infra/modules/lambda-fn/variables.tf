variable "function_name" {
  type = string
}

variable "handler" {
  type = string     
}
variable "runtime" {
    type = string     
}
variable "filename" {
    type = string
}
variable "environment" {
    type = map(string) 
    default = {}
}

variable "dlq_arn" {
  description = "ARN of the SQS DLQ to attach to the Lambda (optional)"
  type        = string
  default     = null
}
