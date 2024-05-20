# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.terraform1-day1.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.my_igw.id
#   }

# }


# # Create Private Route Table
# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.terraform1-day1.id
    
#     route {
#         cidr_block = "0.0.0.0/0"
#         nat_gateway_id  = aws_nat_gateway.nat_gateway_terraform.id    
#     }
# }

resource "aws_route_table" "route_tables" {
  count=2
  vpc_id = aws_vpc.terraform1-day1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = count.index == 0? aws_internet_gateway.my_igw.id:aws_nat_gateway.nat_gateway_terraform.id
  }
  tags = {
    Name = "${var.common_resource_name}_route_table"
  }

}

# Attach Public Route Table to Public Subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.subnets["public1"].id
  route_table_id = aws_route_table.route_tables[0].id
}

# Attach Private Route Table to private Subnet
resource "aws_route_table_association" "private1_association" {
  subnet_id      = aws_subnet.subnets["private1"].id
  route_table_id = aws_route_table.route_tables[1].id
}

resource "aws_route_table_association" "private2_association" {
  subnet_id      = aws_subnet.subnets["private2"].id
  route_table_id = aws_route_table.route_tables[1].id
}