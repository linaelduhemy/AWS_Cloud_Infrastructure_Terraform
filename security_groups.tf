# Security Group allowing SSH from anywhere
resource "aws_security_group" "public_security_group_ssh" {
  name        = "ssh-from-anywhere"
  description = "Allow SSH from anywhere"

  # vpc_id = aws_vpc.terraform1-day1.id
  vpc_id = module.mynetwork.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.common_resource_name}_SSH from Anywhere"
  }
}

# Security Group allowing SSH and port 3000 from VPC CIDR only
resource "aws_security_group" "private_security_group_ssh_and_3000_from_vpc" {
  name        = "ssh-and-3000-from-vpc"
  description = "Allow SSH and port 3000 from VPC CIDR only"

  # vpc_id = aws_vpc.terraform1-day1.id
  vpc_id = module.mynetwork.vpc_id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.mynetwork.vpc_cidr]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [module.mynetwork.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.common_resource_name}_SSH and Port 3000 from VPC"
  }
}

resource "aws_security_group" "RDS_security_group"{
  name = "RDS_security_group"
  vpc_id = module.mynetwork.vpc_id

  ingress{
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [module.mynetwork.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.common_resource_name}_RDS_security_group"
  }
}

resource "aws_security_group" "redis_security_group"{
  name = "redis_security_group"
  vpc_id = module.mynetwork.vpc_id

  ingress{
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [module.mynetwork.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.common_resource_name}_redis_security_group"
  }
}