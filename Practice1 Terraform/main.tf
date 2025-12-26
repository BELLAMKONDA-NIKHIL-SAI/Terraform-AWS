resource "aws_instance" "practice" {
    ami           = var.OS
    instance_type = var.size
    
    tags = {
        Name = var.name
    }
}

resource "aws_s3_bucket" "practice" {
    bucket = var.bucketname
}

resource "aws_iam_user" "Terraform_User"{
    name = "${var.username}-usernikhil"
}

output "IPaddress" {
    value = aws_instance.practice.public_ip
}

output "Dns_address" {
    value = aws_instance.practice.public_dns
}