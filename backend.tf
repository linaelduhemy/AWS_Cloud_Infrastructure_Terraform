terraform {
  backend "s3" {
    bucket = "terraform-s3-day2"
    key    = "terraform.tfstate"
    dynamodb_table = "state-lock-test"
    region = "us-east-1"
  }
}
