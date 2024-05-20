data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


# Create EC2 Instance for Bastion Host in Public Subnet
resource "aws_instance" "public_instance_bastion" {
  ami             = data.aws_ami.ubuntu.id  # Specify your desired AMI ID
  instance_type   = var.machine_details["type"]     # Specify your desired instance type
  # subnet_id       = aws_subnet.subnets["public1"].id
  subnet_id = module.mynetwork.subnets["public1"].id
  associate_public_ip_address = true
  security_groups = [aws_security_group.public_security_group_ssh.id]
  
  key_name  = aws_key_pair.key4.key_name

  tags = {
    Name = "${var.common_resource_name}_bastion host"
  }

  user_data = <<-EOF
    #!/bin/bash
    echo '${tls_private_key.key4.private_key_pem}' > /home/ubuntu/key4.pem
    chmod 400 key4.pem
    chown ubuntu:ubuntu key4.pem
  EOF

  provisioner "local-exec" {
    command= "echo ${self.public_ip} > inventory "
  }
}

# Create EC2 Instance for Application in Private Subnet
resource "aws_instance" "application_server" {
  ami             = data.aws_ami.ubuntu.id  # Specify your desired AMI ID
  instance_type   = var.machine_type      # Specify your desired instance type
  # subnet_id       = aws_subnet.subnets["private1"].id
  subnet_id = module.mynetwork.subnets["private1"].id
  security_groups = [aws_security_group.private_security_group_ssh_and_3000_from_vpc.id]
  
  key_name  = aws_key_pair.key4.key_name

  tags = {
    Name = "${var.common_resource_name}_application server"
  }
}

