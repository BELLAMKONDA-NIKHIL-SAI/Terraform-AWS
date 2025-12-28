# Create S3 bucket
resource "aws_s3_bucket" "tf_bucket" {
    bucket = "my-tf-practice2-bucket-84989"
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "tf_bucket_versioning" {
    bucket = aws_s3_bucket.tf_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}