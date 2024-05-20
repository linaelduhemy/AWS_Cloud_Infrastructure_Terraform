resource "aws_db_subnet_group" "my_rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [module.mynetwork.subnets["private1"].id, module.mynetwork.subnets["private2"].id]

  tags = {
    Name = "${var.common_resource_name}_RDS_Subnet_Group"
  }
}

resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "_%!"
}

resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 10
  db_name              = "my_rds_db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "lina"
  password             = random_password.rds_password.result
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true #don't create fina; snapshot when deleting rds instance
  db_subnet_group_name  = aws_db_subnet_group.my_rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.RDS_security_group.id]
}

# Saving rds password to be added in jenkins credentials
resource "local_file" "rds_password_file" {
  content  = aws_db_instance.rds_instance.password
  filename = "rds_password.txt"
}