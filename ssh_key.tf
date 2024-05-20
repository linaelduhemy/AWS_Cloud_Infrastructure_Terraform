## create it in aws site
resource "aws_key_pair" "key4" {
  key_name   = "${var.key_name}"
  public_key = tls_private_key.key4.public_key_openssh
}

#take the private key & put it in local file
resource "local_file" "private_key_file" {
  count= var.create_key_file==true?1:0
  content  = tls_private_key.key4.private_key_pem
  filename = "${var.key_name}.pem"
}

# RSA key of size 4096 bits
##ssh key generate
resource "tls_private_key" "key4" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "private_key" {
  value    = tls_private_key.key4.private_key_pem
  sensitive = true  # Marking the output as sensitive
}

output "public_key" {
  value = tls_private_key.key4.public_key_openssh
}