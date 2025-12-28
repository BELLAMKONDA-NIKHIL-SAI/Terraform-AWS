terraform {
    backend "s3" {
        bucket = "my-tf-statefile-bucket-84989"
        key   = "practice-2/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
    }

    required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.27.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}