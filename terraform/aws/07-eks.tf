resource "aws_eks_cluster" "eks_cluster" {
  name     = "${local.project_name}-eks"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids         = aws_subnet.public[*].id
    security_group_ids = [aws_security_group.nodes.id]
  }
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
  tags = {
    Name = "${local.project_name}-eks"
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${local.project_name}-node"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = aws_subnet.public[*].id

  scaling_config {
    desired_size = 1
    max_size     = 10
    min_size     = 1
  }


  instance_types = ["t3.small"]
  capacity_type  = "SPOT" # Reduce costs

  depends_on = [
    aws_iam_role_policy_attachment.attach_eks_nodes
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = {
    Name = "${local.project_name}-node"
  }
}
resource "aws_eks_access_entry" "github_actions_access" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  principal_arn = var.github_actions_role
  type          = "STANDARD"
}
# www
resource "aws_eks_access_policy_association" "github_actions_access_association" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.github_actions_access.principal_arn

  access_scope {
    type = "cluster"
  }
}
resource "aws_eks_access_entry" "eks_access" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  principal_arn = var.your_role_or_user
  type          = "STANDARD"
}
resource "aws_eks_access_policy_association" "eks_access_association" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.eks_access.principal_arn

  access_scope {
    type = "cluster"

  }
}
