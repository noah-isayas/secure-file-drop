variable "queue_name" {
  description = "The name of the SQS queue"
  type        = string
  
}

variable "message_retention_seconds" {
  description = "The number of seconds for which Amazon SQS retains a message"
  type        = number
  default     = 345600 # 4 days in seconds
    validation {
        condition     = var.message_retention_seconds <= 1209600
        error_message = "The maximum retention is 1209600 seconds (14 days)."
    }
  
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the SQS queue in seconds"
  type        = number
  default     = 30
  
}
    