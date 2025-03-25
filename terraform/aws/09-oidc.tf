
# data "aws_caller_identity" "current" {}

# resource "aws_iam_role" "oidc" {
#   name = "${local.project_name}-oidc-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRoleWithWebIdentity",
#         Effect = "Allow",
#         Principal = {
#           Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(local.eks_oidc_issuer_url, "https://", "")}"
#         },
#         Condition = {
#           StringEquals = {
#             "${replace(local.eks_oidc_issuer_url, "https://", "")}:sub" : "system:serviceaccount:kube-system:${local.project_name}-sa"
#           }
#         }
#       }
#     ]
#   })
# }


# resource "aws_iam_policy" "oidc" {
#   name = "${local.project_name}-oidc-policy"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = [
#           "autoscaling:*",
#           "eks:*",
#           "ec2:*",
#           "cloudwatch:*",
#         ],
#         Effect   = "Allow",
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "oidc" {
#   role       = aws_iam_role.oidc.name
#   policy_arn = aws_iam_policy.oidc.arn
# }

# data "tls_certificate" "eks_oidc" {
#   url = local.eks_oidc_issuer_url
# }

# resource "aws_iam_openid_connect_provider" "oidc" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.eks_oidc.certificates[0].sha1_fingerprint]
#   url             = local.eks_oidc_issuer_url
# }

