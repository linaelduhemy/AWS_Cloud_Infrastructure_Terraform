output myvpc_id {
  value       = module.mynetwork.vpc_id
  sensitive   = false
  description = "description"
}


# output instance_public_ip {
#   value       = aws_instance.public_instance_bastion.public_ip
#   sensitive   = false
#   description = "description"
# }

output "elasticache_cluster" {
  value = aws_elasticache_cluster.terraform_elasticache_cluster.arn
}