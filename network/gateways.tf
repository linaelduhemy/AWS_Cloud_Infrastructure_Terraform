resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.terraform1-day1.id
  tags = {
    Name = "${var.common_resource_name}_IGW"
  }
}


# we create it because when we stop the instance and reopen it , it changes its ips each time
#so by elastic ip, hya btzbtli elmwdoo3 da fl 7agat elly mrboota bl instance de zy el nat gatway kda bdl maroo7 azbt el ip elgdeed kol mra bnfsi
resource "aws_eip" "elasticIP_terraform" {
  domain   = "vpc"
  tags = {
    Name = "${var.common_resource_name}_EIP"
  }
}

resource "aws_nat_gateway" "nat_gateway_terraform" {
  allocation_id = aws_eip.elasticIP_terraform.id
  subnet_id     = aws_subnet.subnets["public1"].id

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my_igw]
  tags = {
    Name = "${var.common_resource_name}_NGW"
  }
}