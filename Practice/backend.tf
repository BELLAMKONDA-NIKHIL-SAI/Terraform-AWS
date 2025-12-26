terraform {
    backend "s3" {
        bucket = "nikhil-terraform-state-file-bucket"
        key = "dev/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}