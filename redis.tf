resource "aws_elasticache_subnet_group" "my_redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = [module.mynetwork.subnets["private1"].id, module.mynetwork.subnets["private2"].id]

  tags = {
    Name = "${var.common_resource_name}_redis_Subnet_Group"
  }
}

resource "aws_elasticache_cluster" "terraform_elasticache_cluster" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  
  
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.my_redis_subnet_group.name
  security_group_ids   = [aws_security_group.redis_security_group.id]

  tags = {
    Name = "${var.common_resource_name}_elasticache_cluster"
  }
}