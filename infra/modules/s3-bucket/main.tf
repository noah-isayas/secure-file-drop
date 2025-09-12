resource "aws_s3_bucket" "sfd_file_storage_bucket" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "sfd_file_storage_bucket" {
    bucket = aws_s3_bucket.sfd_file_storage_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  
}

resource "aws_s3_bucket_versioning" "version" {
    bucket = aws_s3_bucket.sfd_file_storage_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "enc_config" {
    bucket = aws_s3_bucket.sfd_file_storage_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
  
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
    count  = var.enable_lifecycle ? 1 : 0
    bucket = aws_s3_bucket.sfd_file_storage_bucket.id

    rule {
        id     = "Delete old versions"
        status = "Enabled"

        expiration {
            days = 30
        }

        filter {
            prefix = ""
        }
    }
}