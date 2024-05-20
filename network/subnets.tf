# resource "aws_subnet" "public_subnet_terraform" {
#   vpc_id     = aws_vpc.terraform1-day1.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone       = "${var.region}a" 

# }

# resource "aws_subnet" "private_subnet_terraform" {
#   vpc_id     = aws_vpc.terraform1-day1.id
#   cidr_block = "10.0.2.0/24"
#   availability_zone       = "${var.region}a" 

# }


resource "aws_subnet" "subnets"{
  for_each = { for subnet in var.subnets_details : subnet.name => subnet }
    vpc_id     = aws_vpc.terraform1-day1.id
    cidr_block        = each.value.cidr
    availability_zone       = "${var.region}${each.value.availability_zone}" 

    tags = {
    Name = "${var.common_resource_name}_${each.value.name}_subnet"
    }
}

