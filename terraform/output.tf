output "region" {

description = "The aws region from locals"
value = local.region

}

output "vpc_id" {

description = "ID of VPC created"
value = module.vpc.vpc_id

}

output "eks_cluster_name" {

description = "EKS cluster Name"
value = module.eks.cluster_name

}

output "eks_cluster_endpoint" {

description = "EKS cluster API endpoint"
value = module.eks.cluster_endpoint

}

output "public_ip" {

description = "Puvblic IP's of EC2 instance"
value = aws_instance.testinstance.public_ip

}

output "eks_node_group_public_ips" {

description = "Public IP's of node groups"
value = data.aws_instances.eks_nodes.public_ips

}
