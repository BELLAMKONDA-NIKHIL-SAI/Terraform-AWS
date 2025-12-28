# Create our RDS DB using TF
resource "aws_db_instance" "mytfdb" {
    instance_class = "db.t3.micro"
    engine = "mysql"
    engine_version = "8.0.43"
    allocated_storage = 20
    storage_type = "gp2"
    identifier = "mytfdbinstance"
    username = "admin"
    password = "Bns.2002"
    publicly_accessible = true
    skip_final_snapshot = true

    tags = {
        Name = "MyTFDBInstance"
    }
}