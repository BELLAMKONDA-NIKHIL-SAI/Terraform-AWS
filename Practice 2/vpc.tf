# Create a VPC
resource "aws_vpc" "tfvpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "MyTFVpc"
    }
}

# Create a public subnet
resource "aws_subnet" "tfpublic_subnet" {
    vpc_id     = aws_vpc.tfvpc.id
    cidr_block = "10.0.1.0/24"
}

# Create a private subnet
resource "aws_subnet" "tfprivate_subnet" {
    vpc_id     = aws_vpc.tfvpc.id
    cidr_block = "10.0.2.0/24"
}

# Create IGW
resource "aws_internet_gateway" "tfigw" {
    vpc_id = aws_vpc.tfvpc.id
}

# Route table for public subnet
resource "aws_route_table" "tfpublic_route_table" {
    vpc_id = aws_vpc.tfvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.tfigw.id
    }
}

# Route table association for public subnet
resource "aws_route_table_association" "tfpublic_route_table_association" {
    subnet_id      = aws_subnet.tfpublic_subnet.id
    route_table_id = aws_route_table.tfpublic_route_table.id
}