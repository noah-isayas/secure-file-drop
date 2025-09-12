variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  
}

variable "enable_lifecycle" {
  description = "Enable lifecycle rule to delete old versions"
  type        = bool
  default     = false
  
}