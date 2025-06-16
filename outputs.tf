output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_endpoint" {
  value = module.eks.cluster_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "instance_id" {
  description = "AMI ID of Ubuntu instance"
  value       = data.aws_ami.amiID.id
}