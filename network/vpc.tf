# resource "aws_dynamodb_table" "terraform_lock" {
#   name           = "terraform-lock-table"
#   billing_mode   = "PAY_PER_REQUEST"  # Use PAY_PER_REQUEST for on-demand capacity mode
#   hash_key       = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name = "${var.common_resource_name}_Lock Table"
#   }
# }


resource "aws_vpc" "terraform1-day1" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.common_resource_name}_VPC"
  }
}






######################################################################################3


###############################################################################

