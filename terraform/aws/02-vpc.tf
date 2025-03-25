resource "aws_vpc" "vpc" {
  cidr_block           = local.vpc
  enable_dns_hostnames = true //for RDS
  tags = {
    Name = "${local.project_name}-vpc"
  }
}
