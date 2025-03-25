
resource "time_sleep" "wait_for_ingress_controller" {
  create_duration = "80s"
  depends_on      = [helm_release.my_app_ingress]
}

data "aws_lb" "ingress_alb" {
  tags = {
    "elbv2.k8s.aws/cluster"    = "${local.project_name}-eks"
    "ingress.k8s.aws/resource" = "LoadBalancer"
  }
  depends_on = [time_sleep.wait_for_ingress_controller]
}

