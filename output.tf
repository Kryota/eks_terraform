output "eks_create_command" {
  description = "EKSのクラスター作成時に使用するコマンド"
  value       = "eksctl create cluster --name eks_handson --vpc-public-subnet ${join(",", module.vpc.public_subnet_ids)} --vpc-private-subnet ${join(",", module.vpc.private_subnet_ids)} --without-nodegroup"
}
