output "ingress_url" {
  value = data.aws_lb.ingress_alb.dns_name
}


# output "database_url" {
#   value = nonsensitive(local.database_url)
#   # sensitive = true
# }

# output "eks_vpc_id" {
#   value = aws_vpc.vpc.id
# }

# output "see" {
#   value = local.ingress_hostname
# }
# output "see2" {
#   value = data.kubernetes_ingress_v1.app_ingress.status[0]
# }
