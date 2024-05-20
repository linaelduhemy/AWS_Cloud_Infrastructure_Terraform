output subnets {
  value       = aws_subnet.subnets
  description = "description"
}


output vpc_id {
  value       = aws_vpc.terraform1-day1.id
  description = "description"
}

output vpc_cidr {
  value       = aws_vpc.terraform1-day1.cidr_block
  description = "description"
}
