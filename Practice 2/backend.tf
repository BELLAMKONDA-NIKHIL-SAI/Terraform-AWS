# S3 bucket for state file
resource "aws_s3_bucket" "tf_statefile_bucket" {
    bucket = "my-tf-statefile-bucket-84989"
    force_destroy = true
}

# Enable versioning for the state file bucket
resource "aws_s3_bucket_versioning" "tf_statefile_bucket_versioning" {
    bucket = aws_s3_bucket.tf_statefile_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}

# Enable server-side encryption for the state file bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_statefile_bucket_encryption" {
    bucket = aws_s3_bucket.tf_statefile_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}
