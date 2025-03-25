resource "aws_eks_addon" "pod_identity" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.5-eksbuild.2"
}

resource "aws_iam_role" "pod_identity" {
  name = "${aws_eks_cluster.eks_cluster.name}-pod-id-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "pod_identity" {
  name = "${aws_eks_cluster.eks_cluster.name}-pod-id-role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "autoscaling:*",
          "ec2:*",
          "eks:*",
          "cloudwatch:*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "pod_identity" {
  policy_arn = aws_iam_policy.pod_identity.arn
  role       = aws_iam_role.pod_identity.name
}

resource "aws_eks_pod_identity_association" "pod_identity" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "kube-system"
  service_account = "cluster-autoscaler"
  role_arn        = aws_iam_role.pod_identity.arn
}

# let node aws can get the aws credentials
resource "aws_eks_pod_identity_association" "node_aws" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = local.namespace
  service_account = "${local.project_name}-node-aws-sa"
  role_arn        = aws_iam_role.pod_identity.arn
}
