module "eks" {

source = "terraform-aws-modules/eks/aws"
version = "~> 20.0"

cluster_name = local.name
cluster_endpoint_public_access = true

cluster_addons = {

coredns = {
most_recent = true
}

kube-proxy = {
most_recent = true
}

vpc-cni = {
most_recent = true
}

}

vpc_id = module.vpc.vpc_id
subnet_ids = module.vpc.public_subnets
control_plane_subnet_ids = module.vpc.intra_subnets

eks_managed_node_group_defaults = {

instance_types = ["t2.large"]
attach_cluster_primary_security_group = true

}


eks_managed_node_groups = {

tws-demo-ng = {

min_size = 2
max_size = 3
desired_size = 2

instance_types = ["t2.large"]
capacity_type = "SPOT"

disk_size = 35
use_custom_launch_template = false

tags = {

Name = "tws-demo-ng"
Environment = "dev"
ExtraTag = "e-commerce-app"

}

# Add inbound rules to the node group security group
    node_security_group_additional_rules = [
      {
        description = "Allow SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow 8080"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

    ]

}

}

tags = local.tags
}


data "aws_instances" "eks_nodes" {

instance_tags = {

"eks:cluster-name" = module.eks.cluster_name

}

filter {
name = "instance-state-name"
values = ["running"]
}
depends_on = [module.eks]
}


