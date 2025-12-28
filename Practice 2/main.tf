# Create multiple EC2 instances with specified AMI and instance type
resource "aws_instance" "practice_instance" {
    ami             = "ami-068c0051b15cdb816"
    instance_type   = "t2.micro"
    count           = 3
    security_groups = [aws_security_group.tf_practice_sg.name]
    
/*
1st method : To use existing key pair from AWS console
*/

    key_name        = "tf_keypair"

    tags = {
        Name = "PracticeInstance ${count.index + 1}"
    }
}

/*
    2nd method : To create a new key pair using Terraform
*/
resource "aws_key_pair" "demo_keypair" {
    key_name   = "tf_keypair"
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "local_file" "tf_keypair" {
    content = tls_private_key.rsa.private_key_pem
    filename = "tf_keypair.pem"
}

# Security group
resource "aws_security_group" "tf_practice_sg" {
    name        = "sg using tf"
    description = "Allow TLS inbound traffic"
    vpc_id      = "vpc-02717df8ba3bb0114"

    tags = {
        Name    = "tf_practice_sg"
    }
}

# Ingress rules for HTTPS 
resource "aws_vpc_security_group_ingress_rule" "https_ipv4" {
    description = "Allow HTTPS inbound traffic from IPv4"
    security_group_id = aws_security_group.tf_practice_sg.id
    cidr_ipv4         = "0.0.0.0/0"
    from_port         = 443
    ip_protocol       = "tcp"
    to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "https_ipv6" {
    description = "Allow HTTPS inbound traffic from IPv6"
    security_group_id = aws_security_group.tf_practice_sg.id
    cidr_ipv6         = "::/0"
    from_port         = 443
    ip_protocol       = "tcp"
    to_port           = 443
}

#Ingress rules for HTTP
resource "aws_vpc_security_group_ingress_rule" "http_ipv4" {
    description = "Allow HTTP inbound traffic from IPv4"
    security_group_id = aws_security_group.tf_practice_sg.id
    cidr_ipv4         = "0.0.0.0/0"
    from_port         = 80
    ip_protocol       = "tcp"
    to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "http_ipv6" {
    description = "Allow HTTP inbound traffic from IPv6"
    security_group_id = aws_security_group.tf_practice_sg.id
    cidr_ipv6         = "::/0"
    from_port         = 80
    ip_protocol       = "tcp"
    to_port           = 80
}

# Ingress rules for SSH
resource "aws_vpc_security_group_ingress_rule" "ssh_ipv4" {
    description = "Allow SSH inbound traffic from IPv4"
    security_group_id = aws_security_group.tf_practice_sg.id
    cidr_ipv4         = "0.0.0.0/0"
    from_port         = 22
    ip_protocol       = "tcp"
    to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "ssh_ipv6" {
    description = "Allow SSH inbound traffic from IPv6"
    security_group_id = aws_security_group.tf_practice_sg.id
    cidr_ipv6         = "::/0"
    from_port         = 22
    ip_protocol       = "tcp"
    to_port           = 22
}

# Egress rules to allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
    description = "Allow all outbound traffic to IPv4"
    security_group_id = aws_security_group.tf_practice_sg.id
    cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
    description = "Allow all outbound traffic to IPv6"
    security_group_id = aws_security_group.tf_practice_sg.id
    cidr_ipv6         = "::/0"
    ip_protocol       = "-1" # semantically equivalent to all ports
}

