locals {
  project_name  = "cpu-monitor"
  namespace     = "default"
  provider_name = "aws"

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  ]
  anyone_access_ip = "0.0.0.0/0"
  vpc              = "10.0.0.0/16"
  subnet_number    = 2
  database_url     = "postgresql://${aws_db_instance.database.username}:${aws_db_instance.database.password}@${aws_db_instance.database.endpoint}/"
  # eks_oidc_issuer_url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer

}

variable "database_username" {}
variable "database_password" {}
variable "your_role_or_user" {}
variable "github_actions_role" {}
