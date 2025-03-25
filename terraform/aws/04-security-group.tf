

resource "aws_security_group" "nodes" {
  vpc_id = aws_vpc.vpc.id
  name   = "${local.project_name}-nodes-sg"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true # Allow inter-node communication
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.project_name}-nodes-sg"
  }
}

resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.vpc.id
  name   = "${local.project_name}-rds-sg"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [for subnet in aws_subnet.public : subnet.cidr_block]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.anyone_access_ip]
  }
  tags = {
    Name = "${local.project_name}-rds-sg"
  }
}
