output "eks_create_command" {
  description = "EKSのクラスター作成時に使用するコマンド"
  value       = "eksctl create cluster --name eks-handson --vpc-public-subnets ${join(",", module.vpc.public_subnet_ids)} --vpc-private-subnets ${join(",", module.vpc.private_subnet_ids)} --without-nodegroup"
}
