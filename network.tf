module "mynetwork" {
    source= "./network"
    vpc_cidr= var.cidr
    common_resource_name= var.common_resource_name
    region= var.region
    subnets_details= var.subnets
}